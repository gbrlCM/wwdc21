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
        HStack(alignment: .top, spacing: 20) {
            VStack(alignment: .leading) {
                Text(repo.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                if let languague = repo.language {
                    Label(title: {
                        Text(languague)
                    }, icon: {
                        Image(systemName: languague == "Swift" ? "swift" : "chevron.left.slash.chevron.right")
                        
                    })
                }
                
                if let description = repo.description {
                    Text(description)
                        .padding(.top, 16)
                }
                Spacer()
            }
            Spacer()
        }
        .padding(.all, 16)
        
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
