//
//  UserService.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 4/2/24.
//

import Foundation
import Firebase

struct UserService {
    
    static func fetchAllUsers() async throws -> [User] {
        let snapshot = try await Firestore.firestore().collection(Constant.userCollection).getDocuments()

        return snapshot.documents.compactMap({try? $0.data(as: User.self)})
    }
}
