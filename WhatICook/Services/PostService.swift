//
//  PostService.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 4/9/24.
//

import Foundation
import Firebase

struct PostService {
    
    private static let postCollection = Firestore.firestore().collection(Constant.postCollection)
    
    static func fetchPost() async throws -> [Post] {
        
        let snapshot = try await Firestore.firestore().collection(Constant.postCollection).order(by: "timestamp", descending: true).getDocuments()
        
        var posts = try snapshot.documents.compactMap({ try $0.data(as: Post.self) })
        
        for i in 0 ..< posts.count {
            let post = posts[i]
            let ownerUid = post.ownerUid
            let postUser = try await UserService.fetchUser(withUid: ownerUid)
            posts[i].user = postUser
        }
        
        return posts
    }
    
    static func fetchUserPost(uid: String) async throws -> [Post] {
        let snapshot = try await postCollection.whereField("ownerUid", isEqualTo: uid).getDocuments()
        var posts = try snapshot.documents.compactMap({ try $0.data(as: Post.self) })
        
        posts.sort(by: { $0.timestamp.compare($1.timestamp) == .orderedDescending })
        
        return posts
    }
    
    static func fetchPost(postId: String) async throws -> Post {
        return try await postCollection.document(postId).getDocument(as: Post.self)
    }
}

// MARK: - Likes

extension PostService {
    static func likePost(_ post: Post) async throws {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        // Async let is used in order to let the following codes run simultaneously
        
        // Adding New Collection Post Likes to the Collection of 'post'
        async let _ = try await postCollection.document(post.id).collection(Constant.postLikes).document(uid).setData([:])
        
        // Updating the likes attributes from post collection by 1
        async let _ = try await postCollection.document(post.id).updateData(["likes": post.likes + 1])
        
        // Adding New Collection User Likes to the Collection of 'user'
        async let _ = Firestore.firestore().collection(Constant.userCollection).document(uid).collection(Constant.userLikes).document(post.id).setData([:])
    }
    
    static func unlikePost(_ post: Post) async throws {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        async let _ = try await postCollection.document(post.id).collection(Constant.postLikes).document(uid).delete()
        
        async let _ = try await postCollection.document(post.id).updateData(["likes": post.likes - 1])
        
        async let _ = Firestore.firestore().collection(Constant.userCollection).document(uid).collection(Constant.userLikes).document(post.id).delete()
    }
    
    static func checkIfUserLikedPost(_ post: Post) async throws -> Bool{
        guard let uid = Auth.auth().currentUser?.uid else {return false}
        
        let snapshot = try await Firestore.firestore().collection(Constant.userCollection).document(uid).collection(Constant.userLikes).document(post.id).getDocument()
        
        return snapshot.exists
    }
    
}
