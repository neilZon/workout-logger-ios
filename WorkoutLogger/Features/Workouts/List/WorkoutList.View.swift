//
//  WorkoutListView.swift
//  WorkoutLogger
//
//  Created by Neil Viloria on 2022-11-20.
//

import SwiftUI

struct WorkoutListView: View {
    @StateObject private var workoutListViewModel = WorkoutListViewModel(service: WorkoutLoggerAPIService())
    
    var body: some View {

        NavigationStack {
            
            VStack {
                
                List {
                    
                    if workoutListViewModel.workoutRoutineList.count > 0 {
                        
                        ForEach(workoutListViewModel.workoutRoutineList, id: \.self.id) { workoutRoutine in
                            
                            NavigationLink(
                                destination: WorkoutDetailsView(workoutRoutineId: workoutRoutine.id).navigationTitle("Routine Details")
                            ) {
                                
                                WorkoutListItemView(
                                    name: workoutRoutine.name,
                                    exerciseCount: workoutRoutine.exerciseRoutines.count
                                )
 
                            }
                            
                        }
                        .onDelete(perform: { indexSet in
                            for i in indexSet {
                                workoutListViewModel.deleteWorkoutRoutine(id: workoutListViewModel.workoutRoutineList[i].id)
                            }
                        })
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color.bgSecondary))
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
                        
                    } else {
                        
                        Text("You don't have any routines here, tap the '+' above to add a workout")
                            .foregroundColor(.tertiaryText)
                            .multilineTextAlignment(.center)
                            .padding()
                        
                    }
                    
                }
                .onAppear(perform: { workoutListViewModel.getWorkoutRoutines() })
                .refreshable {
                    workoutListViewModel.getWorkoutRoutines(withNetwork: true)
                }
                
            }
            .coordinateSpace(name: "pullToRefreshWorkouts")
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    
                    Text("Routines")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    CreateWorkoutView(workoutListViewModel: workoutListViewModel)
                    
                }
                
            }
            
        }
        
    }
}

struct WorkoutListView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutListView().preferredColorScheme(.dark)
    }
}
