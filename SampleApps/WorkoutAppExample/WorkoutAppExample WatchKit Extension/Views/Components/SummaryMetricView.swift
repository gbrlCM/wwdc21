//
//  SummaryMetricView.swift
//  WorkoutAppExample WatchKit Extension
//
//  Created by Gabriel Ferreira de Carvalho on 10/06/21.
//

import SwiftUI

struct SummaryMetricView: View {
    var title: String
    var value: String
    
    var body: some View {
        Text(title)
        Text(value)
            .font(valueFont)
            .foregroundColor(.accentColor)
        
        Divider()
    }
    
    var valueFont: Font {
        .system(.title, design: .rounded)
            .lowercaseSmallCaps()
    }
}

struct SummaryMetricView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryMetricView(title: "title", value: "340")
    }
}
