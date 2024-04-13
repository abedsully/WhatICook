//
//  Comments.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 4/12/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Comments: Identifiable, Codable{
    @DocumentID var commentId: String?
    let postOwnerUid: String
    let commentText: String
    let postId: String
    let timestamp: Timestamp
    let commentOwnerUid: String
    var user: User?
    
    var id: String {
        return commentId ?? NSUUID().uuidString
    }
}
