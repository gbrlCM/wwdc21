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
        
        guard let url = URL(string: "https://api.github.com/users/\(user)") else {
            return false
        }
        
        do {
            let (_ , response) = try await URLSession.shared.data(from: url)
            
            if let httpResponse = response as? HTTPURLResponse {
                    print("statusCode: \(httpResponse.statusCode)")
                if httpResponse.statusCode == 200 { return true }
            }
        } catch {
            return false
        }
        return false
    }
    
    func fetchRepos(from user: String) async throws -> [Repository] {
        guard let url = URL(string: "https://api.github.com/users/\(user)/repos") else {
            throw RequestErrors.invalidURL
        }
        let request = try await URLSession.shared.data(from: url)
        print(request.1)
        
        do {
            let repositories = try JSONDecoder().decode([Repository].self, from: request.0)
            return repositories
        } catch let error {
            throw error
        }
    }
}
