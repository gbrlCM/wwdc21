//
//  UserSelectionViewModel.swift
//  Await
//
//  Created by Gabriel Ferreira de Carvalho on 08/06/21.
//

import Foundation
import SwiftUI

final class UserSelectionViewModel: ObservableObject {
    
    var dataService = GitHubDataservice()
    
    func verifyUser(_ user: String) async -> Bool {
        return await dataService.hasUser(user)
    }
}
