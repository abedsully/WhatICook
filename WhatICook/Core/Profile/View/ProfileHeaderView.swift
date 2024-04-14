//
//  ProfileHeaderView.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 3/31/24.
//

import SwiftUI

struct ProfileHeaderView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @State private var showEditProfile = false
    
    private var user: User {
        return viewModel.user
    }
    
    private var isFollowed: Bool {
        return user.isFollowed ?? false
    }
    
    private var buttonTitle: String {
        if user.isCurrentUser {
            return "Edit Profile"
        } else {
            return isFollowed ? "Following" : "Follow"
        }
    }
    
    private var backgroundColor: Color {
        if user.isCurrentUser || !isFollowed {
            return Constant.mainColor
        } else {
            return .gray
        }
    }
    
    private var stats: UserStats {
        return user.stats ?? .init(followingCount: 0, followersCount: 0, postsCount: 0)
    }
    
    init(user: User) {
        self.viewModel = ProfileViewModel(user: user)
    }
    
    
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
                    UserStatusView(value: stats.postsCount, description: "Posts")
                    UserStatusView(value: stats.followersCount, description: "Followers")
                    UserStatusView(value: stats.followingCount, description: "Followings")
                }
                .padding(.vertical, 8)
            }
            

            // Action Button
            Button {
                if user.isCurrentUser {
                    showEditProfile.toggle()
                } else {
                    handleFollowTapped()
                }
            } label: {
                Text(buttonTitle)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(Constant.textColor)
                    .frame(width: 360, height: 32)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(backgroundColor, lineWidth: 1)
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(backgroundColor)
                    )
            }
            
            
        }
        .padding(.top)
        .fullScreenCover(isPresented: $showEditProfile) {
            EditProfileView(user: user)
        }
    }
    
    func handleFollowTapped() {
        if isFollowed {
            viewModel.unfollow()
        } else {
            viewModel.follow()
        }
    }
}

#Preview {
    ProfileHeaderView(user: User.mockUsers[0])
//        .preferredColorScheme(.dark)
}
