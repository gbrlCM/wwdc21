//
//  RepoListViewModel.swift
//  Await
//
//  Created by Gabriel Ferreira de Carvalho on 08/06/21.
//

import Foundation
import SwiftUI

final class RepoListViewModel: ObservableObject {
    
    @Published var repositories: [Repository] = []
    
    let session = URLSession.shared
    let datasource = GitHubDataservice()
    
    func fetchRepos(from user: String) async throws {
        let repos = try await datasource.fetchRepos(from: user)
        repositories = repos
    }
}
