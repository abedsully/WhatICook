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
        guard let commentData = try? Firestore.Encoder().encode(comment) else {return}
        
        try await Firestore.firestore().collection(Constant.postCollection).document(postId).collection(Constant.postComments).addDocument(data: commentData)
        
    }
    
    func fetchComments() async throws -> [Comments] {
        let snapshot = try await Firestore.firestore().collection(Constant.postCollection).document(postId).collection(Constant.postComments).order(by: "timestamp", descending: true).getDocuments()
        
        return snapshot.documents.compactMap({try? $0.data(as: Comments.self ) })
    }
}

