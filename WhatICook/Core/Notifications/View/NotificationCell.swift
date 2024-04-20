//
//  NotificationCell.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 4/20/24.
//

import SwiftUI

struct NotificationCell: View {
    var body: some View {
        HStack {
            CircularProfileImageView(size: .xSmall)
            
            // Notifications Message
            HStack {
                Text("test ")
                    .font(.subheadline)
                    .fontWeight(.semibold) +
                
                Text("liked one of your posts")
                    .font(.subheadline) +
                
                Text(" 3w")
                    .foregroundStyle(.gray)
                    .font(.footnote)
            }
            
            Spacer()
            
            Image("ProfilePicture")
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipped()
                .padding(.leading, 2)
        }
        .padding(.horizontal)
    }
}

#Preview {
    NotificationCell()
}
