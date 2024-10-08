//
//  ConversationsViewModel.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 4/21/24.
//

import SwiftUI
import Firebase

class ConversationsViewModel: ObservableObject {
    @Published var recentMessages = [Message]()
    private var recentMessagesDictionary = [String: Message]()
    
    func fetchRecentMessages() async throws -> [Message] {
        guard let uid = Auth.auth().currentUser?.uid else { return [] }

        let query = Firestore.firestore().collection("messages")
            .document(uid)
            .collection("recent-messages")
            .order(by: "timestamp", descending: true)
        
        let snapshot = try await query.getDocuments()
        return snapshot.documents.compactMap({ try? $0.data(as: Message.self) })
    }
    
    @MainActor
    func loadData() {
        Task {
            var messages = try await fetchRecentMessages()
            
            for i in 0 ..< messages.count {
                let message = messages[i]
                async let user = try await UserService.fetchUser(withUid: message.chatPartnerId)
                messages[i].user = try await user
                
                let uid = messages[i].user?.id ?? ""
                recentMessagesDictionary[uid] = messages[i]
            }
            
            self.recentMessages = Array(recentMessagesDictionary.values)
        }
    }
}

