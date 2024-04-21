//
//  UserContentListViewModel.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 4/8/24.
//

import Foundation

@MainActor
class UserContentListViewModel: ObservableObject {
    
    private let user: User
    @Published var posts = [Post]()
    @Published var likedPosts = [Post]()
    
    init(user: User) {
        self.user = user
        
        Task {
            try await fetchUserPosts()
        }
        
        Task {
            try await fetchUserLikedPost()
        }
    }
    
    @MainActor
    func fetchUserPosts() async throws {
        self.posts = try await PostService.fetchUserPost(uid: user.id)
        
        
        for i in 0 ..< posts.count {
            posts[i].user = self.user
        }
    }
    
    @MainActor
    func fetchUserLikedPost() async throws{
        do {
            self.likedPosts = try await PostService.fetchLikedPost(uid: user.id)
            for i in 0 ..< likedPosts.count {
                likedPosts[i].user = self.user
            }
        } catch {
            print("Error fetching liked posts: \(error.localizedDescription)")
        }
    }

    
}
