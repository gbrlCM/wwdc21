//
//  UserSelectionView.swift
//  Await
//
//  Created by Gabriel Ferreira de Carvalho on 08/06/21.
//

import SwiftUI

struct UserSelectionView: View {
    @Binding var userLogin: String
    @Binding var shouldNavigate: Bool
    @State var isLoading: Bool = false
    @State var didFailLoading: Bool = false
    @StateObject var viewModel: UserSelectionViewModel = UserSelectionViewModel()
    
    var body: some View {
        VStack {
            Text("Select a user")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 16)
            HStack {
                TextField("User", text: $userLogin)
                    
                Button(action: {
                    async {
                        await advanceScreen(forUser: userLogin)
                    }
                }, label: {
                    Label(title: {
                        Text("Enter")
                        
                    }, icon: {
                        if isLoading {
                            ProgressView()
                        } else {
                            Image(systemName: "lock.circle")
                        }
                        
                    })
                })
                    .buttonStyle(.bordered)
                
            }.padding(.leading, 16)
                .padding(.trailing, 16)
                .padding(.top, 16)
                .padding(.bottom, 16)
            if didFailLoading {
                Text("Failed loading a user, please check the name and try again")
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
            }
        }
        .navigationBarHidden(true)
        .padding(.leading, 16)
        .padding(.trailing, 16)
    }
    
    func advanceScreen(forUser user: String) async {
        isLoading = true
        if await viewModel.verifyUser(user) {
            shouldNavigate = true
            didFailLoading = false
        } else {
            didFailLoading = true
        }
        isLoading = false
    }
}

struct UserSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        UserSelectionView(userLogin: .constant(""), shouldNavigate: .constant(false))
    }
}
