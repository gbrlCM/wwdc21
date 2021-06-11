//
//  WorkoutAppExampleApp.swift
//  WorkoutAppExample WatchKit Extension
//
//  Created by Gabriel Ferreira de Carvalho on 10/06/21.
//

import SwiftUI

@main
struct WorkoutAppExampleApp: App {
    @StateObject var workoutService = WorkoutService()
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                StartView()
            }.sheet(isPresented: $workoutService.showingSummaryView) {
                SummaryView()
            }
            .environmentObject(workoutService)
        
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
