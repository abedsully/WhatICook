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
        
        let snapshot = try await Firestore.firestore().collection(Constant.postCollection).getDocuments()
        
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
        return try snapshot.documents.compactMap({ try $0.data(as: Post.self) })
    }
}
