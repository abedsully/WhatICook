//
//  ProfileHeaderView.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 3/31/24.
//

import SwiftUI

struct ProfileHeaderView: View {
    let user: User
    @State private var showEditProfile = false
    
    var body: some View {
        VStack (spacing: 10){
            
            // Profile Picture and Status
            VStack {
                CircularProfileImageView(user: user, size: .large)
                    .padding(.bottom, 8)
                
                if let fullname = user.fullName {
                    Text(fullname)
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                
                if let bio = user.bio {
                    Text(bio)
                        .font(.footnote)
                }
                
                HStack {
                    UserStatusView(value: 5, description: "Posts")
                    UserStatusView(value: 12, description: "Followers")
                    UserStatusView(value: 24, description: "Followings")
                }
                .padding(.vertical, 8)
            }
            

            // Action Button
            Button {
                if user.isCurrentUser {
                    showEditProfile.toggle()
                } else {
                    print("Follow")
                }
            } label: {
                Text(user.isCurrentUser ? "Edit Profile" : "Follow")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(Constant.textColor)
                    .frame(width: 360, height: 32)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Constant.mainColor, lineWidth: 1)
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Constant.mainColor)
                    )
            }
            
            
        }
        .padding(.top)
        .fullScreenCover(isPresented: $showEditProfile) {
            EditProfileView(user: user)
        }
    }
}

#Preview {
    ProfileHeaderView(user: User.mockUsers[0])
}
