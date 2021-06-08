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
    @Binding var userName: String
    
    var body: some View {
        List(viewModel.repositories) { repo in
            RepoCell(repo: repo)
        }
        .listStyle(.plain)
        .navigationTitle(Text("Repositories"))
        .task {
            do {
                try await viewModel.fetchRepos(from: userName)
            } catch let error {
                print(error)
            }
        }
    }
}

struct RepoListView_Previews: PreviewProvider {
    static var previews: some View {
        RepoListView(userName: .constant("gbrlCM"))
    }
}
