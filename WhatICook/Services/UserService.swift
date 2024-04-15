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
    
    static func fetchUsers(forConfig config: UserListConfig) async throws -> [User] {
        switch config {
        case .followers(let uid):
            return try await fetchFollowers(uid: uid)
        case .following(let uid):
            return try await fetchFollowing(uid: uid)
        case .likes(let postId):
            return try await fetchPostLikeUsers(postId: postId)
        case .explore:
            return try await fetchAllUsers()
        }
    }
    
    private static func fetchFollowers(uid: String) async throws -> [User] {
        let snapshot = try await Firestore.firestore().collection(Constant.followersCollection).document(uid).collection(Constant.userFollowers).getDocuments()
        return try await fetchUsers(snapshot)
    }
    
    private static func fetchFollowing(uid: String) async throws -> [User] {
        let snapshot = try await Firestore.firestore().collection(Constant.followingCollection).document(uid).collection(Constant.userFollowing).getDocuments()
        return try await fetchUsers(snapshot)
    }
    
    private static func fetchPostLikeUsers(postId: String) async throws -> [User] {
        let snapshot = try await Firestore.firestore().collection(Constant.postCollection).document(postId).collection(Constant.postLikes).getDocuments()
        return try await fetchUsers(snapshot)
    }
    
    private static func fetchUsers(_ snapshot: QuerySnapshot) async throws -> [User] {
        var users = [User]()
        
        for doc in snapshot.documents {
            users.append(try await fetchUser(withUid: doc.documentID))
        }
        
        return users
    }
    
}

// MARK: - User Stats

extension UserService {
    static func fetchUserStats(uid: String) async throws -> UserStats {
        async let followingCount = Firestore.firestore().collection(Constant.followingCollection).document(uid).collection(Constant.userFollowing).getDocuments().count
        
        
        async let followersCount =  Firestore.firestore().collection(Constant.followersCollection).document(uid).collection(Constant.userFollowers).getDocuments().count
        
        
        async let postsCount =  Firestore.firestore().collection(Constant.postCollection).whereField("ownerUid", isEqualTo: uid).getDocuments().count
        
        
        return try await .init(followingCount: followingCount, followersCount: followersCount, postsCount: postsCount)
    }
}
