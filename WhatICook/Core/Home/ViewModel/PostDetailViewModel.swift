//
//  PostDetailViewModel.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 4/22/24.
//

import Foundation
import Firebase

@MainActor
class PostDetailViewModel: ObservableObject {
    @Published var post: Post
    @Published var didLike: Bool = false
    
    init(post: Post) {
        self.post = post
        Task {
            try await checkIfUserLikedPost()
        }
        fetchPost()
    }
    
    func fetchPost(){
        Task {
            self.post = try await PostService.fetchPost(postId: post.id)
        }
    }
    
    func checkIfUserLikedPost() async throws {
        self.didLike = try await PostService.checkIfUserLikedPost(post)
    }
}
