//
//  ProfileViewModel.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 4/14/24.
//

import Foundation

@MainActor
class ProfileViewModel: ObservableObject {
    @Published var user: User
    
    init(user: User) {
        self.user = user
    }
    
    func fetchUserStats() {
        guard user.stats == nil else {return} 
        Task {
            self.user.stats = try await UserService.fetchUserStats(uid: user.id)
        }
    }
}

extension ProfileViewModel {
    func follow() {
        Task {
            try await UserService.follow(uid: user.id)
            user.isFollowed = true
            NotificationManager.shared.uploadFollowNotification(toUid: user.id)
            
            if let count = user.stats?.followersCount {
                if count >= 0 {
                    user.stats?.followersCount += 1
                }
            }
            
        }
    }
    
    func unfollow() {
        Task {
            try await UserService.unfollow(uid: user.id)
            user.isFollowed = false
            if let count = user.stats?.followersCount {
                if count == 0 {
                    user.stats?.followersCount = 0
                } else {
                    user.stats?.followersCount -= 1
                }
            }
            await NotificationManager.shared.deleteFollowNotification(toUid: user.id)
        }
    }
    
    func checkIfUserIsFollowed() {
        guard user.isFollowed == nil else {return}
        Task {
            self.user.isFollowed = try await UserService.checkIfUserIsFollowed(uid: user.id)
        }
    }
    
}
