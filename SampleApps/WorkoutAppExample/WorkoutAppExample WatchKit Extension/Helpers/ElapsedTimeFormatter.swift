//
//  ElapsedTimeFormatter.swift
//  WorkoutAppExample WatchKit Extension
//
//  Created by Gabriel Ferreira de Carvalho on 10/06/21.
//
import Foundation

class ElapsedTimeFormatter: Formatter {
    
    let componentsFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    
    var showSubseconds = true
    
    override func string(for obj: Any?) -> String? {
        guard
            let time = obj as? TimeInterval,
            let formattedStrings = componentsFormatter.string(from: time)
        
        else {
            return nil
        }
        
        if self.showSubseconds {
            let hundredths = Int((time.truncatingRemainder(dividingBy: 1)) * 100)
            let decimalSeparator = Locale.current.decimalSeparator ?? "."
            return String(format: "%@%@%0.2d", formattedStrings, decimalSeparator, hundredths)
        }
        
        return formattedStrings
    }
}
