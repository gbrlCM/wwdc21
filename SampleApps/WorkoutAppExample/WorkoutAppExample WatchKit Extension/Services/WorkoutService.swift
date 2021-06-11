//
//  WorkoutManager.swift
//  WorkoutAppExample WatchKit Extension
//
//  Created by Gabriel Ferreira de Carvalho on 10/06/21.
//

import Foundation
import HealthKit

class WorkoutService: NSObject, ObservableObject {
    
    var selectedWorkout: HKWorkoutActivityType? {
        didSet {
            guard selectedWorkout != nil else { return }
            startWorkout(ofType: selectedWorkout!)
        }
    }
    
    let healthStore = HKHealthStore()
    var session: HKWorkoutSession?
    var builder: HKLiveWorkoutBuilder?
    
    @Published var sessionState: Bool = false
    @Published var averageHeartRate: Double = 0
    @Published var heartRate: Double = 0
    @Published var activeEnergy: Double = 0
    @Published var distance: Double = 0
    @Published var workout: HKWorkout?
    
    @Published var showingSummaryView: Bool = false {
        didSet {
            if !showingSummaryView {
                resetWorkout()
            }
        }
    }
    
    func requestAuthorization() {
        
        let typesToShare: Set = [
            HKQuantityType.workoutType()
        ]
        
        let typeToRead: Set = [
            HKQuantityType.quantityType(forIdentifier: .heartRate)!,
            HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKQuantityType.quantityType(forIdentifier: .distanceCycling)!,
            HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!,
            HKQuantityType.activitySummaryType()
        ]
        
        healthStore.requestAuthorization(toShare: typesToShare, read: typeToRead) { (success, error) in
            
        }
    }
    
    func startWorkout(ofType workoutType: HKWorkoutActivityType) {
        
        let configuration = HKWorkoutConfiguration()
        configuration.activityType = workoutType
        configuration.locationType = .outdoor
        
        do {
            session = try HKWorkoutSession(healthStore: healthStore, configuration: configuration)
            builder = session?.associatedWorkoutBuilder()
            builder?.delegate = self
            session?.delegate = self
            
        } catch {
            
            return
        }
        
        builder?.dataSource = HKLiveWorkoutDataSource(healthStore: healthStore, workoutConfiguration: configuration)
        let startDate = Date()
        session?.startActivity(with: startDate)
        builder?.beginCollection(withStart: startDate) { (sucess, error) in
            
        }
    }
    
    //MARK: State Control
    
    func pause() {
        session?.pause()
    }
    
    func resume() {
        session?.resume()
    }
    
    func tooglePause() {
        if sessionState {
            pause()
        } else {
            resume()
        }
    }
    
    func endWorkout() {
        session?.end()
        showingSummaryView = true
    }
    
    func resetWorkout() {
        selectedWorkout = nil
        builder = nil
        session = nil
        workout = nil
        activeEnergy = 0
        averageHeartRate = 0
        heartRate = 0
        distance = 0
    }
}

extension WorkoutService: HKWorkoutSessionDelegate {
    func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: Error) {
        
    }
    
    
    func workoutSession(_ workoutSession: HKWorkoutSession, didChangeTo toState: HKWorkoutSessionState, from fromState: HKWorkoutSessionState, date: Date) {
        DispatchQueue.main.async {
            self.sessionState = toState == .running
        }
        
        if toState == .ended {
            async {
                do {
                    try await builder?.endCollection(at: date)
                    let workout = try await builder?.finishWorkout()
                    await assignWorkout(workout)
                    
                } catch {
                    print("Error")
                }
            }
        }
    }
    
    @MainActor func assignWorkout(_ workout: HKWorkout?) {
        self.workout = workout
    }
    
}

extension WorkoutService: HKLiveWorkoutBuilderDelegate {
    func workoutBuilder(_ workoutBuilder: HKLiveWorkoutBuilder, didCollectDataOf collectedTypes: Set<HKSampleType>) {
        for type in collectedTypes {
            guard let quantityType = type as? HKQuantityType else { return }
            
            let statistics = workoutBuilder.statistics(for: quantityType)
            async {
                await updateForStatistics(statistics)
            }
        }
    }
    
    func workoutBuilderDidCollectEvent(_ workoutBuilder: HKLiveWorkoutBuilder) {
        
    }
    
    @MainActor func updateForStatistics(_ statistics: HKStatistics?) async {
        guard let statistics = statistics else { return }
        
        switch statistics.quantityType {
        case HKQuantityType.quantityType(forIdentifier: .heartRate):
            let heartRateUnit = HKUnit.count().unitDivided(by: HKUnit.minute())
            self.heartRate = statistics.mostRecentQuantity()?.doubleValue(for: heartRateUnit) ?? 0
            self.averageHeartRate = statistics.averageQuantity()?.doubleValue(for: heartRateUnit) ?? 0
        case HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned):
            let energyUnit = HKUnit.kilocalorie()
            self.activeEnergy = statistics.sumQuantity()?.doubleValue(for: energyUnit) ?? 0
        case HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning), HKQuantityType.quantityType(forIdentifier: .distanceCycling):
            let meterUnit = HKUnit.meter()
            self.distance = statistics.sumQuantity()?.doubleValue(for: meterUnit) ?? 0
        default:
            return
        }
    }
}
