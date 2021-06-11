//
//  SummaryView.swift
//  WorkoutAppExample WatchKit Extension
//
//  Created by Gabriel Ferreira de Carvalho on 10/06/21.
//

import SwiftUI
import HealthKit

struct SummaryView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var workoutService: WorkoutService
    
    @State private var durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    
    var body: some View {
        if workoutService.workout == nil {
            loadingView
        } else {
            scrollView
        }
    }
    
    @ViewBuilder
    var scrollView: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                SummaryMetricView(title: "Total Time:", value: durationFormatter.string(from: workoutService.workout?.duration ?? 0.0) ?? "")
                    .accentColor(.yellow)
                
                SummaryMetricView(
                    title: "Total Distance",
                    value: Measurement(
                        value: workoutService.workout?.totalDistance?.doubleValue(for: .meter()) ?? 0.0,
                        unit:UnitLength.meters
                    ).formatted(.measurement(
                        width: .abbreviated, usage: .road))
                ).accentColor(.green)
                
                SummaryMetricView(
                    title: "Total Energy",
                    value: Measurement(value: workoutService.workout?.totalEnergyBurned?.doubleValue(for: .kilocalorie()) ?? 0, unit: UnitEnergy.kilocalories)
                        .formatted(
                            .measurement(
                                width: .abbreviated,
                                usage: .workout,
                                numberFormat: .numeric(precision: .fractionLength(0))
                            )
                        )
                ).accentColor(.pink)
                
                SummaryMetricView(
                    title: "Avg. Heart Rate",
                    value: workoutService.averageHeartRate.formatted(.number.precision(.fractionLength(0))) + " bpm"
                ).accentColor(.red)
                
                Text("Activity Rings")
                ActivityRingsView(healthStore: HKHealthStore())
                    .frame(width: 50, height: 50)
                
                Button("Done") {
                    dismiss()
                }
            }.scenePadding()
        }
        .navigationTitle("Summary")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    var loadingView: some View {
        ProgressView("Saving workout")
            .navigationBarHidden(true)
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView()
    }
}
