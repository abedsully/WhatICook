//
//  PostCellViewModel.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 4/11/24.
//

import Foundation

@MainActor
class PostCellViewModel: ObservableObject {
    @Published var post: Post
    
    init(post: Post) {
        self.post = post
        Task { try await checkIfUserLikedPost() }
    }
    
    func like() async throws {
        do {
            let postCopy = post
            post.didLike = true
            post.likes += 1
            try await PostService.likePost(postCopy)
            NotificationManager.shared.uploadLikeNotification(toUid: post.ownerUid, post: post)
        } catch {
            post.didLike = false
            post.likes -= 1
        }
    }
    
    func unlike() async throws {
        do {
            let postCopy = post
            post.didLike = false
            post.likes -= 1
            try await PostService.unlikePost(postCopy)
            await NotificationManager.shared.deleteLikeNotification(toUid: post.ownerUid, post: post)
        } catch {
            post.didLike = true
            post.likes += 1
        }
    }
    
    func checkIfUserLikedPost() async throws {
        self.post.didLike = try await PostService.checkIfUserLikedPost(post)
    }
    
    func deletePost() async throws {
        do {
            try await PostService.deletePost(postId: post.id)
        } catch {
            print("Error deleting post: \(error.localizedDescription)")
        }
    }
}
