//
//  CurrentUserProfileView.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 3/31/24.
//

import SwiftUI

struct CurrentUserProfileView: View {
    
    let user: User
    
    var posts: [Post] {
        return Post.mockPost.filter({ $0.user?.username == user.username })
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                // Header View
                ProfileHeaderView(user: user)
                
                // Grid View
                UserContentListView(user: user)
            }
            .navigationTitle(user.username)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        AuthService.shared.signOut()
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(Constant.textColor)
                    }

                }
            }
        }
    }
}
#Preview {
    CurrentUserProfileView(user: User.mockUsers[0])
}
