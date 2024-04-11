//
//  Post.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 3/31/24.
//

import Foundation
import Firebase

struct Post: Identifiable, Codable, Hashable {
    let id: String
    let ownerUid: String
    var likes: Int
    let foodName: String
    let category: String
    let description: String
    let ingredients: String
    let instructions: String
    let imageURL: String
    let timestamp: Timestamp
    var user: User?
    
    var didLike: Bool? = false
}

extension Post {
    static var mockPost: [Post] = [
        .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, likes: 26, foodName: "Pizza", category: "Fast Food", description: "American Style Pizza", ingredients: "a lot", instructions: "1. Cook, 2. Serve, 3. Eat", imageURL: "pizza", timestamp: Timestamp(), user: User.mockUsers[0]),
        .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, likes: 22, foodName: "Pempek", category: "Seafood", description:"Pempek khas palembang", ingredients: "a lot", instructions: "1. Cook, 2. Serve, 3. Eat", imageURL: "pempek", timestamp: Timestamp(), user: User.mockUsers[1]),
        .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, likes: 18, foodName: "Es Campur", category: "Beverages", description: "Es Campur Enak", ingredients: "a lot", instructions: "1. Cook, 2. Serve, 3. Eat", imageURL: "es campur", timestamp: Timestamp(), user: User.mockUsers[2])
    ]
}
