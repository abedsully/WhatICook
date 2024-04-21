//
//  Notification.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 4/20/24.
//

import Firebase

struct Notification: Identifiable, Codable {
    let id: String
    var postId: String?
    let timestamp: Timestamp
    let senderUid: String
    let type: NotificationType
    
    var post: Post?
    var user: User?
}
