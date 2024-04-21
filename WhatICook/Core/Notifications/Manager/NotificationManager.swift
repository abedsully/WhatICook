//
//  NotificationManager.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 4/21/24.
//

import Foundation

class NotificationManager {
    
    static let shared = NotificationManager()
    
    private let service = NotificationService()
    
    private init() {
        
    }
    
    func uploadLikeNotification(toUid uid: String, post: Post) {
        service.uploadNotifications(toUid: uid, type: .like, post: post)
    }
    
    func uploadCommentNotification(toUid uid: String, post: Post) {
        service.uploadNotifications(toUid: uid, type: .comment, post: post)
    }
    
    func uploadFollowNotification(toUid uid: String) {
        service.uploadNotifications(toUid: uid, type: .follow)
    }
    
    func deleteLikeNotification(toUid uid: String, post: Post) async{
        do {
            try await service.deleteNotifications(toUid: uid, type: .like, post: post)
        } catch {
            print("DEBUG: Failed to delete notifications \(error.localizedDescription)")
        }
    }
    
    func deleteFollowNotification(toUid uid: String) async {
        do {
            try await service.deleteNotifications(toUid: uid, type: .follow)
        } catch {
            print("DEBUG: Failed to delete notifications \(error.localizedDescription)")
        }
    }
    
}
