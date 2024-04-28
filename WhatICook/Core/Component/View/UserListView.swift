//
//  UserListView.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 4/15/24.
//

import SwiftUI

struct UserListView: View {
    
    @StateObject var viewModel = UserListViewModel()
    @State private var searchText = ""
    @ObservedObject var viewModelSearch = SearchViewModel(config: .search)
    
    private let config: UserListConfig
    
    init(config: UserListConfig) {
        self.config = config
    }
    
    var body: some View {
        ScrollView {
            LazyVStack (spacing: 16){
                ForEach(searchText.isEmpty ? viewModel.users : viewModelSearch.filteredUsers(searchText)) { user in
                    NavigationLink(value: user) {
                        HStack {
                            CircularProfileImageView(user: user, size: .small)
                            
                            VStack (alignment: .leading){
                                Text(user.username)
                                    .fontWeight(.semibold)
                                
                                if let fullname = user.fullName {
                                    Text(fullname)
                                }
                            }
                            .font(.footnote)
                            .foregroundColor(Constant.textColor)
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                }
                .navigationDestination(for: User.self, destination: { user in
                    ProfileView(user: user)
                })
                .padding(.top, 8)
                .searchable(text: $searchText, prompt: "Enter name")
            }
            .task {
                await viewModel.fetchUsers(forConfig: config)
            }
        }
    }
}

#Preview {
    UserListView(config: .explore)
}
