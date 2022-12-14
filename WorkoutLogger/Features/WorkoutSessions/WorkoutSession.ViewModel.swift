//
//  WorkoutSessionViewModel.swift
//  WorkoutLogger
//
//  Created by Neil Viloria on 2022-12-02.
//

import Foundation

class WorkoutSessionViewModel: ObservableObject {
    private let service: WorkoutLoggerAPIServiceProtocol
    
    @Published var workoutSessionList: [WorkoutSession] = []
    @Published var error: String?

    init(service: WorkoutLoggerAPIServiceProtocol) {
        self.service = service
    }
    
    func getWorkoutSessions(withNetwork: Bool = false) {
        self.service.getWorkoutSessions(limit: 8, after: "", withNetwork: withNetwork) { result in
            switch result {
            case .success(let workoutSessions):
                self.error = nil
                self.workoutSessionList = workoutSessions
            case .failure(let err):
                self.error = err.localizedDescription
            }
        }
    }
    
    func addWorkoutSession(workoutRoutineId: String, start: Date) {
        self.service.addWorkoutSession(id: workoutRoutineId, start: start) { result in
            switch result {
            case .success:
                self.error = nil
                self.getWorkoutSessions(withNetwork: true)
            case .failure(let err):
                self.error = err.localizedDescription
            }

        }
    }
}
