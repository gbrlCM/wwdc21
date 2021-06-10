import Foundation

enum HttpRequestErrors: Error {
    case badURL
    case badRequest
    case badResultDecoding
}


func fetchListOfIds() async throws -> [Int] {
    
    guard let url = URL(string: "https://hacker-news.firebaseio.com/v0/topstories.json") else {
        throw HttpRequestErrors.badURL
    }
    
    guard
        let (data, response) = try? await URLSession.shared.data(from: url),
        let httpResponse = response as? HTTPURLResponse,
        httpResponse.statusCode == 200
        
    else {
        throw HttpRequestErrors.badRequest
    }
    
    guard let listOfStories = try? JSONDecoder().decode([Int].self, from: data) else {
        throw HttpRequestErrors.badResultDecoding
    }
    
    return listOfStories
}

var data: [Int] = []

