//
//  Workout.ViewModel.swift
//  WorkoutLogger
//
//  Created by Neil Viloria on 2022-11-22.
//

import Foundation
import Apollo

class WorkoutListViewModel: ObservableObject {
    private let service: WorkoutLoggerAPIServiceProtocol
   
    @Published var error: String?
    @Published var editError: String?
    @Published var workoutRoutineList: [WorkoutRoutineFull] = []
    
    init(service: WorkoutLoggerAPIServiceProtocol) {
        self.service = service
    }
    
    func getWorkoutRoutines() {
        self.service.getWorkoutRoutines() { result in
            switch result {
            case .success(let workoutRoutines):
                self.error = nil
                self.workoutRoutineList = workoutRoutines
            case .failure(let err):
                self.error = err.localizedDescription
            }
        }
    }
}