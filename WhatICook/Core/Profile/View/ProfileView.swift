//
//  ProfileView.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 3/30/24.
//

import SwiftUI

struct ProfileView: View {
    
    let user: User
    
    var posts: [Post] {
        return Post.mockPost.filter({ $0.user?.username == user.username })
    }
    

    var body: some View {
            ScrollView {
                // Header View
                ProfileHeaderView(user: user)
                
                
                UserContentListView(user: user)

            }
            .navigationTitle(user.username)
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ProfileView(user: User.mockUsers[0])
}
