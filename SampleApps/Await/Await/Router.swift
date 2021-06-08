//
//  ContentView.swift
//  Await
//
//  Created by Gabriel Ferreira de Carvalho on 08/06/21.
//

import SwiftUI

struct Router: View {
    @State var userSelectionNavigation: Bool = false
    @State var cellNavigation: Bool = false
    @State var userName: String = ""
    
    
    var body: some View {
        NavigationView {
            VStack {
                UserSelectionView(userLogin: $userName, shouldNavigate: $userSelectionNavigation)
                NavigationLink(destination: RepoListView(userName: $userName), isActive: $userSelectionNavigation, label: { EmptyView() })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Router()
    }
}
