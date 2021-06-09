//
//  GitHubDataservice.swift
//  Await
//
//  Created by Gabriel Ferreira de Carvalho on 08/06/21.
//

import Foundation

struct GitHubDataservice {
    
    enum RequestErrors: Error {
        case invalidURL
        case failedFetching
    }
    
    func hasUser(_ user: String) async -> Bool {
        
        guard
            let url = URL(string: "https://api.github.com/users/\(user)"),
            let (_ , response) = try? await URLSession.shared.data(from: url),
            let httpResponse = response as? HTTPURLResponse
        else {
            return false
        }
        
        if httpResponse.statusCode == 200 { return true }
        return false
    }
    
    func fetchRepos(from user: String) async throws -> [Repository] {
        guard let url = URL(string: "https://api.github.com/users/\(user)/repos") else {
            throw RequestErrors.invalidURL
        }
        
        do {
            let request = try await URLSession.shared.data(from: url)
            let repositories = try JSONDecoder().decode([Repository].self, from: request.0)
            return repositories
        } catch {
            throw RequestErrors.failedFetching
        }
    }
}
