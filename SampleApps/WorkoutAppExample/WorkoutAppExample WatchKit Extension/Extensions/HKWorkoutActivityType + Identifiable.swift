//
//  HKWorkoutActivityType + Identifiable.swift
//  WorkoutAppExample WatchKit Extension
//
//  Created by Gabriel Ferreira de Carvalho on 10/06/21.
//

import Foundation
import HealthKit

extension HKWorkoutActivityType: Identifiable {
    
    public var id: UInt {
        rawValue
    }

    var name: String {
        switch self {
        case .cycling:
            return "Cycling"
        case .walking:
            return "Walking"
        case .running:
            return "Running"
        default:
            return ""
        }
    }
}
