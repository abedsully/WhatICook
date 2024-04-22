//
//  CommentsService.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 4/12/24.
//

import FirebaseFirestoreSwift
import Firebase

struct CommentsService {
    
    let postId: String
    
    func uploadComment(_ comment: Comments) async throws {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let commentData = try? Firestore.Encoder().encode(comment) else {return}
        
        let post = try await PostService.fetchPost(postId: postId)
        
        async let _ = Firestore.firestore().collection(Constant.postCollection).document(postId).collection(Constant.postComments).addDocument(data: commentData)
        async let _ = Firestore.firestore().collection(Constant.postCollection).document(postId).updateData(["comments": post.comments + 1])
        async let _ = Firestore.firestore().collection(Constant.userCollection).document(uid).collection(Constant.userLikes).document(post.id).updateData(["comments": post.comments + 1])
    }
    
    func fetchComments() async throws -> [Comments] {
        let snapshot = try await Firestore.firestore().collection(Constant.postCollection).document(postId).collection(Constant.postComments).order(by: "timestamp", descending: true).getDocuments()
        
        return snapshot.documents.compactMap({try? $0.data(as: Comments.self ) })
    }
}

