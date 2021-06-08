//
//  RepoView.swift
//  Await
//
//  Created by Gabriel Ferreira de Carvalho on 08/06/21.
//

import SwiftUI

struct RepoView: View {
    var repo: Repository
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .navigationTitle(repo.name)
            .onAppear(perform: {print(repo.name)})
    }
}

struct RepoView_Previews: PreviewProvider {
    static var previews: some View {
        RepoView(repo: Repository(
            id: 0,
            name: "WWDC 2021",
            description: "Doing some fun stuff", language: "Swift", isPrivate: false, url: ""))
    }
}
