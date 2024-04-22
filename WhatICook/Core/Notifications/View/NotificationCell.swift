//
//  NotificationCell.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 4/20/24.
//

import SwiftUI
import Kingfisher

struct NotificationCell: View {
    
    let notification: Notification
    
    var body: some View {
        HStack {
            NavigationLink(value: notification.user) {
                CircularProfileImageView(user: notification.user, size: .xSmall)
            }
            
            // Notifications Message
            HStack {
                Text(notification.user?.username ?? "")
                    .font(.subheadline)
                    .fontWeight(.semibold) +
                
                Text(" \(notification.type.notificationMessage)")
                    .font(.subheadline) +
                
                Text(" \(notification.timestamp.timestampString())")
                    .foregroundStyle(.gray)
                    .font(.footnote)
            }
            
            Spacer()
        
            if notification.type != .follow {
                NavigationLink(value: notification.post) {
                    KFImage(URL(string: notification.post?.imageURL ?? ""))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipped()
                        .padding(.leading, 2)
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    NotificationCell(notification: DeveloperPreview.shared.notifications[0])
}
