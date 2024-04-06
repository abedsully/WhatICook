//
//  SearchViewModel.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 4/2/24.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        Task {try await fetchAllUsers()}
    }
    
    @MainActor
    func fetchAllUsers() async throws{
        self.users = try await UserService.fetchAllUsers()
    }
}
