//
//  ContentView.swift
//  URLSession
//
//  Created by Gabriel Ferreira de Carvalho on 09/06/21.
//

import SwiftUI
import Combine

extension URLSession {
    
    enum HttpRequestErrors: Error {
        case badURL
        case badRequest
        case badResultDecoding
    }
    
    func jsonDecodedData<DecodedData: Decodable>(_ dataType: DecodedData.Type, from url: URL?) async throws -> DecodedData {
        guard let url = url else {
            throw HttpRequestErrors.badURL
        }
        
        guard
            let (data, response) = try? await URLSession.shared.data(from: url),
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200
            
        else {
            throw HttpRequestErrors.badRequest
        }
        
        guard let decodedData = try? JSONDecoder().decode(dataType, from: data) else {
            throw HttpRequestErrors.badResultDecoding
        }
        
        return decodedData
    }
}

struct ContentView: View {
    
    let session = URLSession.shared
    
    struct Story: Codable {
        var id: Int
        var title: String?
        var type: String
        var url: String?
    }
    
    func fetchListOfIds() async throws -> [Int] {
        let listOfItemsUrl = URL(string: "https://hacker-news.firebaseio.com/v0/topstories.json")
        return try await session.jsonDecodedData([Int].self, from: listOfItemsUrl)
    }
    
    func fetchItemFrom(id: Int) async throws -> Story {
        let itemURL = URL(string: "https://hacker-news.firebaseio.com/v0/item/\(id).json")
        
        return try await session.jsonDecodedData(Story.self, from: itemURL)
    }
    
    var body: some View {
        Text("Hello, world!")
            .padding()
            .task {
                do {
                    let data = try await fetchListOfIds()
                    var items: [Story] = []
                    print(data)
                    try await withThrowingTaskGroup(of: Story.self) { group in
                        for id in data {
                            group.async {
                                return try await fetchItemFrom(id: id)
                            }
                        }
                        
                        for try await story in group {
                            items.append(story)
                        }
                    }
                    
                    print(items)
                } catch let error {
                    print(error)
                }
                
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
