//
//  MetricsView.swift
//  WorkoutAppExample WatchKit Extension
//
//  Created by Gabriel Ferreira de Carvalho on 10/06/21.
//

import SwiftUI
import HealthKit

struct MetricsView: View {
    
    @EnvironmentObject var workoutService: WorkoutService
    
    var body: some View {
        TimelineView(MetricsTimelineSchedule(from: workoutService.builder?.startDate ?? Date())) { context in
            VStack(alignment: .leading) {
                ElapsedTimeView(
                    elapsedTime: workoutService.builder?.elapsedTime ?? 0,
                    showSubseconds: context.cadence == .live
                )
                callorieMetter
                beatsPerMinute
                distance
                
            }.frame(maxWidth: .infinity, alignment: .leading)
            .font(metricsFont)
            .ignoresSafeArea(edges: .bottom)
            .scenePadding()
        }
    }
    
    @ViewBuilder
    var callorieMetter: some View {
        Text(
            Measurement(value: workoutService.activeEnergy, unit: UnitEnergy.kilocalories)
                .formatted(
                    .measurement(
                        width: .abbreviated,
                        usage: .workout,
                        numberFormat: .numeric(
                            precision: .fractionLength(0)
                        )
                    )
                )
        )
    }
    
    @ViewBuilder
    var beatsPerMinute: some View {
        Text(
            workoutService.heartRate
                .formatted(
                    .number.precision(.fractionLength(0)))
            + " bpm"
        )
    }
    
    @ViewBuilder
    var distance: some View {
        Text(
            Measurement(
                value: workoutService.distance,
                unit: UnitLength.meters
            ).formatted(
                .measurement(
                    width: .abbreviated,
                    usage: .road
                )
            )
        )
    }
    
    var metricsFont: Font {
        .system(.title, design: .rounded)
            .monospacedDigit()
            .lowercaseSmallCaps()
    }
}

struct MetricsView_Previews: PreviewProvider {
    static var previews: some View {
        MetricsView()
    }
}
