//
//  EditWorkout.View.swift
//  WorkoutLogger
//
//  Created by Neil Viloria on 2022-11-30.
//

import SwiftUI

struct EditWorkout: View {
    @StateObject var workoutViewModel: WorkoutViewModel
    @State var showAlert: Bool = false
    
    @Binding var showSheet: Bool
    @State var workoutRoutine: WorkoutRoutine
    
    var body: some View {
        
        ZStack {

            VStack {

                HStack {

                    Button("Cancel") {

                        showSheet = false

                    }.buttonStyle(TextButton())

                    Spacer()

                    Text("Edit Routine")
                        .bold()

                    Spacer()

                    Button("Done") {

                        workoutViewModel.updateWorkoutRoutine(workoutRoutine) {
                            showSheet = false
                        }

                    }.buttonStyle(TextButton())

                }
                .padding(.top)
                .padding(.horizontal)

                VStack {

                    EditWorkoutName(name: $workoutRoutine.name)
                        .padding(.bottom, 20)

                    EditExerciseRoutineList(
                        exerciseRoutines: $workoutRoutine.exerciseRoutines,
                        onDelete: { idx in
                            if !workoutViewModel.isLoading {
                                workoutRoutine.exerciseRoutines.remove(atOffsets: idx)
                            }
                        }
                    )

                    Button(action: { showAlert.toggle() }) {

                        Text("Add exercise")

                    }
                    .buttonStyle(RoundedButton())
                    .alert("Add exercise", isPresented: $showAlert) {
                        AddExerciseRoutineAlert(
                            onAdd: { exerciseName in
                                workoutRoutine.exerciseRoutines.append(ExerciseRoutine(
                                    id: "",
                                    name: exerciseName,
                                    sets: 0,
                                    reps: 0
                                ))
                            }
                        )

                    }

                }
                
            }

        }
        
    }
}

struct EditWorkout_Previews: PreviewProvider {
    static var previews: some View {
        EditWorkout(
            workoutViewModel: WorkoutViewModel(service: WorkoutLoggerAPIService()),
            showSheet: .constant(true),
            workoutRoutine: WorkoutRoutine(id: "0", name: "Legs", exerciseRoutines: [
                ExerciseRoutine(id: "1", name: "exercise", sets: 5, reps: 4),
                ExerciseRoutine(id: "2", name: "exercise", sets: 5, reps: 4),
                ExerciseRoutine(id: "3", name: "exercise", sets: 5, reps: 4)
            ])
        ).preferredColorScheme(.dark)
    }
}
