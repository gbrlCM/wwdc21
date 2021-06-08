//
//  ContentView.swift
//  Await
//
//  Created by Gabriel Ferreira de Carvalho on 08/06/21.
//

import SwiftUI

struct Router: View {
    var body: some View {
        NavigationView {
            RepoListView()
                .navigationTitle("Repositories")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Router()
    }
}
