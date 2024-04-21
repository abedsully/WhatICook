//
//  SearchViewModel.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 4/2/24.
//

import Foundation

enum SearchViewModelConfig: Hashable {
    case search
    case newMessage
    
    var navigationTitle: String {
        switch self {
        case .search:
            return "Explore"
        case .newMessage:
            return "NewMessage"
        }
    }
}



class SearchViewModel: ObservableObject {
    private let config: SearchViewModelConfig
    @Published var users = [User]()
    
    init(config: SearchViewModelConfig) {
        self.config = config
        Task {try await fetchAllUsers()}
    }
    
    @MainActor
    func fetchAllUsers() async throws{
        self.users = try await UserService.fetchAllUsers()
    }
    
    func filteredUsers(_ query: String) -> [User] {
        let lowercasedQuery = query.lowercased()
        return users.filter({
            $0.fullName?.lowercased().contains(lowercasedQuery) ?? false ||
            $0.username.contains(lowercasedQuery)
        })
    }
}
