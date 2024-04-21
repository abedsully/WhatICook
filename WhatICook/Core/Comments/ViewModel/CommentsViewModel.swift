//
//  CommentsViewModel.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 4/12/24.
//

import Foundation
import Firebase

@MainActor
class CommentsViewModel: ObservableObject {
    @Published var comments = [Comments]()
    
    private let post: Post
    private let service: CommentsService
    
    init(post: Post) {
        self.post = post
        self.service = CommentsService(postId: post.id)
        
        Task { try await fetchComments() }
    }
    
    func uploadComment(commentText: String) async throws{
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let comment = Comments(postOwnerUid: post.ownerUid, commentText: commentText, postId: post.id, timestamp: Timestamp(), commentOwnerUid: uid)
        
        try await service.uploadComment(comment)
        try await fetchComments()
        NotificationManager.shared.uploadCommentNotification(toUid: post.ownerUid, post: post)
    }
    
    @MainActor
    func fetchComments() async throws{
        self.comments = try await service.fetchComments()
        try await fetchUserDataForComments()
    }
    
    private func fetchUserDataForComments() async throws {
        for i in 0 ..< comments.count {
            let comment = comments[i]
            let user = try await UserService.fetchUser(withUid: comment.commentOwnerUid)
            comments[i].user = user
        }
    }
}
