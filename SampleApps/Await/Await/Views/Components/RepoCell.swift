//
//  RepoCell.swift
//  Await
//
//  Created by Gabriel Ferreira de Carvalho on 08/06/21.
//

import SwiftUI

struct RepoCell: View {
    var repo: Repository
    var imageSize: CGFloat = 50
    
    var body: some View {
        NavigationLink (destination: RepoView(repo: repo), label: {
            VStack {
                HStack {
                    Text("\(repo.name)")
                        .fontWeight(.bold)
                        .font(.title2)
                    if repo.isPrivate {
                        Image(systemName: "lock")
                    } else {
                        Image(systemName: "lock.open")
                    }
                    Spacer()
                }
                
                if let description = repo.description {
                    HStack {
                        Text(description)
                        Spacer()
                    }
                }
            }
        })
        .padding(.leading, 8)
        .padding(.trailing, 8)
    }
}

struct RepoCell_Previews: PreviewProvider {
    static var previews: some View {
        RepoCell(repo: Repository(
            id: 0,
            name: "WWDC 2021",
            description: "Doing some fun stuff", language: "Swift", isPrivate: false, url: ""))
    }
}
