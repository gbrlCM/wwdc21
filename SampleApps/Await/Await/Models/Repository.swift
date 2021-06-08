//
//  Repository.swift
//  Await
//
//  Created by Gabriel Ferreira de Carvalho on 08/06/21.
//

import Foundation

struct Repository: Decodable, Identifiable {
    let id: Int
    let name: String
    let description: String?
    let language: String?
    let isPrivate: Bool
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case description = "description"
        case language = "language"
        case isPrivate = "private"
        case url = "html_url"
    }
}
