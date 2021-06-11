//
//  ControlsView.swift
//  WorkoutAppExample WatchKit Extension
//
//  Created by Gabriel Ferreira de Carvalho on 10/06/21.
//

import SwiftUI

struct ControlsView: View {
    
    @EnvironmentObject var workoutService: WorkoutService
    
    var body: some View {
        HStack {
            controlButton(named: "End", symbolName: "xmark") {
                workoutService.endWorkout()
            }
                .tint(.red)
            controlButton(
                named: workoutService.sessionState ? "Pause" : "Resume",
                symbolName: workoutService.sessionState ? "pause" : "play"
            ) {
                workoutService.tooglePause()
            }
                .tint(.yellow)
        }
    }
    
    @ViewBuilder
    func controlButton(named name: String, symbolName: String, action: @escaping () -> Void) -> some View {
        VStack {
            Button {
                action()
            } label: {
                Image(systemName: symbolName)
            }.font(.title2)
            Text(name)
        }
    }
}

struct ControlsView_Previews: PreviewProvider {
    static var previews: some View {
        ControlsView()
    }
}
