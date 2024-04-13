//
//  UserService.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 4/2/24.
//

import Foundation
import Firebase

class UserService {
    
    @Published var currentUser: User?
    
    static let shared = UserService()
    
    @MainActor
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        self.currentUser = try await Firestore.firestore().collection(Constant.userCollection).document(uid).getDocument(as: User.self)
    }
    
    static func fetchUser(withUid uid: String) async throws -> User {
        let snapshot = try await Firestore.firestore().collection(Constant.userCollection).document(uid).getDocument()
        return try snapshot.data(as: User.self)
    }
    
    static func fetchAllUsers() async throws -> [User] {
        let snapshot = try await Firestore.firestore().collection(Constant.userCollection).getDocuments()

        return snapshot.documents.compactMap({try? $0.data(as: User.self)})
    }
    
}
