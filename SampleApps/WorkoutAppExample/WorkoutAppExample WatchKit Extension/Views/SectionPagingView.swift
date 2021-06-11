//
//  SectionPagingView.swift
//  WorkoutAppExample WatchKit Extension
//
//  Created by Gabriel Ferreira de Carvalho on 10/06/21.
//

import SwiftUI
import WatchKit

struct SectionPagingView: View {
    @Environment(\.isLuminanceReduced) var isLuminanceReduced
    @EnvironmentObject var workoutService: WorkoutService
    @State private var selection: Tab = .metrics
    
    enum Tab {
        case control, metrics, nowPlaying
    }
    
    var body: some View {
        TabView(selection: $selection) {
            ControlsView().tag(Tab.control)
            MetricsView().tag(Tab.metrics)
            NowPlayingView().tag(Tab.nowPlaying)
        }
        .navigationTitle(workoutService.selectedWorkout?.name ?? "")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(selection == .nowPlaying)
        .onChange(of: workoutService.sessionState) { _ in
            displayMetricsView()
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: isLuminanceReduced ? .never : .automatic ))
        .onChange(of: isLuminanceReduced) {_ in
            displayMetricsView()
        }
        
    }
    
    private func displayMetricsView() {
        withAnimation {
            selection = .metrics
        }
    }
}

struct SectionPagingView_Previews: PreviewProvider {
    static var previews: some View {
        SectionPagingView()
    }
}
