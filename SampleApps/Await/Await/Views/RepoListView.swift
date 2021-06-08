//
//  RepoListView.swift
//  Await
//
//  Created by Gabriel Ferreira de Carvalho on 08/06/21.
//

import SwiftUI

struct RepoListView: View {
    
    @StateObject var viewModel: RepoListViewModel = RepoListViewModel()
    @State var shouldMove: Bool = false
    
    var body: some View {
        List(0 ..< viewModel.repositories.count) { index in
 
            NavigationLink(
                destination:
                    RepoView(repo: viewModel.repositories[index]),
                isActive: $shouldMove,
                label: {
                    RepoCell(repo: viewModel.repositories[index])
            })
        }
        .listStyle(.plain)
        .task {
            do {
                try await viewModel.fetchRepos()
            } catch let error {
                print(error)
            }
        }
    }
}

struct RepoListView_Previews: PreviewProvider {
    static var previews: some View {
        RepoListView()
    }
}
