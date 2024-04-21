//
//  NotificationsView.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 4/20/24.
//

import SwiftUI

struct NotificationsView: View {
    @StateObject var viewModel = NotificationsViewModel(service: NotificationService())
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack (spacing: 20){
                    ForEach(viewModel.notifications) { notification in
                        NotificationCell(notification: notification)
                            .padding(.top)
                    }
                }
            }
            .refreshable {
                Task {
                    await viewModel.fetchNotifications()
                }
            }
            .navigationTitle("Notifications")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: User.self) { user in
                ProfileView(user: user)
            }
            .navigationDestination(for: Post.self) { post in
                PostCell(post: post)
            }
        }
    }
}

#Preview {
    NotificationsView()
}
