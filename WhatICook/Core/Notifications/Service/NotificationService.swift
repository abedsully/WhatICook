//
//  NotificationService.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 4/21/24.
//

import Firebase

class NotificationService {
    
    func fetchNotifications() async throws -> [Notification] {
        guard let currentUid = Auth.auth().currentUser?.uid else {return []}
        
        let snapshot = try await Firestore.firestore().collection(Constant.notificationCollection).document(currentUid).collection("user-notifications").order(by: "timestamp", descending: true).getDocuments()
        
        return snapshot.documents.compactMap( {try? $0.data(as: Notification.self)} )
    }
    
    func uploadNotifications(toUid uid: String, type: NotificationType, post: Post? = nil) {
        guard let currentUid = Auth.auth().currentUser?.uid, uid != currentUid else {return}
        let ref = Firestore.firestore().collection(Constant.notificationCollection).document(uid).collection("user-notifications").document()
        
        let notification = Notification(id: ref.documentID, postId: post?.id, timestamp: Timestamp(), senderUid: currentUid, type: type)
        
        guard let notificationData = try? Firestore.Encoder().encode(notification) else {return}
        
        ref.setData(notificationData)
    }
    
    func deleteNotifications(toUid uid: String, type: NotificationType, post: Post? = nil) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        
        let snapshot = try await Firestore.firestore().collection(Constant.notificationCollection).document(uid).collection("user-notifications").whereField("senderUid", isEqualTo: currentUid).getDocuments()
        
        let notifications = snapshot.documents.compactMap( {try? $0.data(as: Notification.self) })
        
        // Get Notifications By Type
        let filteredByType = notifications.filter( {$0.type == type} )
        
        if type == .follow {
            for notification in filteredByType {
                try await Firestore.firestore().collection(Constant.notificationCollection).document(uid).collection("user-notifications").document(notification.id).delete()
            }
            
        } else {
            // Get Notifications For That Post
            guard let notificationToDelete = filteredByType.first(where: {$0.postId == post?.id} ) else {return}
            
            try await Firestore.firestore().collection(Constant.notificationCollection).document(uid).collection("user-notifications").document(notificationToDelete.id).delete()
        }

    }
}
