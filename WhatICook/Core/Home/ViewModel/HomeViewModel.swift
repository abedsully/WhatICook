//
//  HomeViewModel.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 4/8/24.
//

import Foundation
import Firebase

class HomeViewModel: ObservableObject {
    @Published var posts = [Post]()
    
    init() {
        Task {try await fetchPosts()}
    }
    
    @MainActor
    func fetchPosts() async throws {
        self.posts = try await PostService.fetchPost()
    }
}
