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

// MARK: - Following

extension UserService {
    static func follow(uid: String) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        
        async let _ = try await Firestore.firestore().collection(Constant.followingCollection).document(currentUid).collection(Constant.userFollowing).document(uid).setData([:])
        
        async let _ = try await Firestore.firestore().collection(Constant.followersCollection).document(uid).collection(Constant.userFollowers).document(currentUid).setData([:])
    }
    
    static func unfollow(uid: String) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        
        async let _ = try await Firestore.firestore().collection(Constant.followingCollection).document(currentUid).collection(Constant.userFollowing).document(uid).delete()
        
        async let _ = try await Firestore.firestore().collection(Constant.followersCollection).document(uid).collection(Constant.userFollowers).document(currentUid).delete()
    }
    
    static func checkIfUserIsFollowed(uid: String) async throws -> Bool{
        guard let currentUid = Auth.auth().currentUser?.uid else {return false}
        
        let snapshot = try await Firestore.firestore().collection(Constant.followingCollection).document(currentUid).collection(Constant.userFollowing).document(uid).getDocument()
        
        return snapshot.exists
    }
    
}

// MARK: - User Stats

extension UserService {
    static func fetchUserStats(uid: String) async throws -> UserStats {
        async let followingSnapshot = try await Firestore.firestore().collection(Constant.followingCollection).document(uid).collection(Constant.userFollowing).getDocuments()
        let followingCount = try await followingSnapshot.count
        
        async let followersSnapshot = try await Firestore.firestore().collection(Constant.followersCollection).document(uid).collection(Constant.userFollowers).getDocuments()
        let followersCount = try await followersSnapshot.count
        
        async let postsSnapshot = try await Firestore.firestore().collection(Constant.postCollection).whereField("ownerUid", isEqualTo: uid).getDocuments()
        let postsCount = try await postsSnapshot.count
        
        return .init(followingCount: followingCount, followersCount: followersCount, postsCount: postsCount)
    }
}
