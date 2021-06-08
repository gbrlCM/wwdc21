//
//  RepoListViewModel.swift
//  Await
//
//  Created by Gabriel Ferreira de Carvalho on 08/06/21.
//

import Foundation
import SwiftUI

final class RepoListViewModel: ObservableObject {
    
    @Published var repositories: [Repository] = [] {
        didSet {
            print(self.repositories)
        }
    }
    let session = URLSession.shared
    
    func fetchRepos() async throws {
        guard let url = URL(string: "https://api.github.com/users/gbrlCM/repos") else {
            return
        }
        let request = try await session.data(from: url)
        print(request.1)
        
        do {
            let repositories = try JSONDecoder().decode([Repository].self, from: request.0)
            self.repositories = repositories
        } catch let error {
            print(error)
        }
        
    }
}
