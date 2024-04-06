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
            HStack {
                Image(user.profileImageURL ?? "")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                
                Spacer()

                UserStatusView(value: 5, description: "Posts")
                UserStatusView(value: 12, description: "Followers")
                UserStatusView(value: 24, description: "Followings")
                
                
            }
            .padding(.horizontal)

            // Name and Bio
            VStack (alignment: .leading){
                if let fullname = user.fullName {
                    Text(fullname)
                        .fontWeight(.semibold)
                }
                    
                if let bio = user.bio {
                    Text(bio)
                }
                
                Text(user.username)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .font(.footnote)

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
