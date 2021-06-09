//
//  GitHubDataServiceTests.swift
//  Await
//
//  Created by Gabriel Ferreira de Carvalho on 08/06/21.
//

import Foundation

class GitDataService {
    private(set) var someBool: Bool = false
    
    func toogleBool() async {
        someBool.toggle()
    }
    
    func toogleWithCompletion(_ action: @escaping (Result<Bool, Error>) -> Void) {
        someBool.toggle()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            action(.success(self.someBool))
        }
    }
}
