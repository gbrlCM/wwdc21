//
//  ContentView.swift
//  WorkoutAppExample WatchKit Extension
//
//  Created by Gabriel Ferreira de Carvalho on 10/06/21.
//

import SwiftUI
import HealthKit

struct StartView: View {
    
    let workoutTypes: [HKWorkoutActivityType] = [.cycling, .walking, .running]
    
    @EnvironmentObject var workoutService: WorkoutService
    
    var body: some View {
        List(workoutTypes) { workoutType in
            NavigationLink (
                workoutType.name,
                destination: SectionPagingView(),
                tag: workoutType,
                selection: $workoutService.selectedWorkout
            ).padding(
                EdgeInsets(
                    top: 15,
                    leading: 5,
                    bottom: 15,
                    trailing: 5
                )
            )
        }
        .listStyle(.carousel)
        .navigationBarTitle("Workouts")
        .onAppear {
            workoutService.requestAuthorization()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
