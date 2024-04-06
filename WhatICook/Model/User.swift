//
//  User.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 3/31/24.
//

import Foundation
import Firebase

struct User: Identifiable, Codable, Hashable {
    let id: String
    var username: String
    var profileImageURL: String?
    var fullName: String?
    var bio: String?
    let email: String
    
    var isCurrentUser: Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else {return false}
        return currentUid == id
    }
}

extension User {
    static var mockUsers: [User] = [
        .init(id: NSUUID().uuidString, username: "abedsully", profileImageURL: Constant.profilePicture, fullName: "Stefanus Albert Wilson", bio: "Professional Chef", email: "abed@gmail.com"),
        .init(id: NSUUID().uuidString, username: "cristiano", profileImageURL: Constant.profilePicture, fullName: "Cristiano Ronaldo", bio: "Professional Chef", email: "abed@gmail.com"),
        .init(id: NSUUID().uuidString, username: "leomessi", profileImageURL: Constant.profilePicture, fullName: "Lionel Messi", bio: "Professional Chef", email: "abed@gmail.com"),
    ]
}
