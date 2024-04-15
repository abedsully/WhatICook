//
//  UserListViewModel.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 4/15/24.
//

import Foundation

@MainActor
class UserListViewModel: ObservableObject {
    @Published var users = [User]()
    
    func fetchUsers(forConfig config: UserListConfig) async {
        do {
            self.users = try await UserService.fetchUsers(forConfig: config)
        } catch {
            print("Failed to fetch users \(error.localizedDescription)")
        }
    }
}
