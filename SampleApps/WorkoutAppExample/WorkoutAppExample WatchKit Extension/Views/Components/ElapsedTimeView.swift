//
//  ElapsedTimeView.swift
//  WorkoutAppExample WatchKit Extension
//
//  Created by Gabriel Ferreira de Carvalho on 10/06/21.
//

import SwiftUI

struct ElapsedTimeView: View {
    var elapsedTime: TimeInterval = 0
    var showSubseconds: Bool = true {
        didSet {
            timeFormatter.showSubseconds = showSubseconds
        }
    }
    @State private var timeFormatter = ElapsedTimeFormatter()
    
    var body: some View {
        Text(NSNumber(value: elapsedTime), formatter: timeFormatter)
            .foregroundColor(.yellow)
            .fontWeight(.semibold)
    }
}

struct ElapsedTimeView_Previews: PreviewProvider {
    static var previews: some View {
        ElapsedTimeView()
    }
}
