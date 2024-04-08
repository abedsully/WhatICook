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
        let snapshot = try await Firestore.firestore().collection(Constant.postCollection).getDocuments()
//        self.posts = try snapshot.documents.compactMap({ document in
//            let post = try document.data(as: Post.self)
//            return post
//        })
        
//        more efficient way
        self.posts = try snapshot.documents.compactMap({ try $0.data(as: Post.self) })
        
        for i in 0 ..< posts.count {
            let post = posts[i]
            let ownerUid = post.ownerUid
            let postUser = try await UserService.fetchUser(withUid: ownerUid)
            posts[i].user = postUser
        }
    }
}
