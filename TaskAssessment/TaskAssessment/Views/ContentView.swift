//
//  ContentView.swift
//  TaskAssessment
//
//  Created by SARO BEAR on 26/04/24.
//  Copyright © 2024 TechieButler. All rights reserved.
//

import SwiftUI

struct UsersList: View {
    let users: [User]
    let isLoading: Bool
    let onScrolledAtBottom: () -> Void
    
    var body: some View {
        NavigationView {
            List {
                usersList
                if isLoading {
                    loadingIndicator
                }
            }
            .navigationBarTitle(Text("Users"))
        }
    }
    
    private var usersList: some View {
        ForEach(users) { user in
            NavigationLink(destination: UserDetails(user: user)) {
                UserRow(user: user).onAppear {
                    if self.users.last == user {
                        self.onScrolledAtBottom()
                    }
                }
            }
        }
    }
    
    private var loadingIndicator: some View {
        Spinner(style: .medium)
            .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
    }
}

struct ContentView: View {
    
    @ObservedObject private var viewModel = UserListViewModel()
    
    var body: some View {
        UsersList(
            users: viewModel.state.users,
            isLoading: true,
            onScrolledAtBottom: viewModel.fetchNextPageIfPossible
        )
        .onAppear(perform: viewModel.fetchNextPageIfPossible)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
