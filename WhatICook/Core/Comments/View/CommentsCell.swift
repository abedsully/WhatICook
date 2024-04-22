//
//  CommentsCell.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 4/12/24.
//

import SwiftUI

struct CommentsCell: View {
    
    let comment: Comments
    
    private var user: User? {
        return comment.user
    }
    
    var body: some View {
        
        NavigationLink(value: comment.user) {
            HStack {
                CircularProfileImageView(user: user, size: .xSmall)
                
                VStack (alignment: .leading, spacing: 4) {
                    HStack (spacing: 2) {
                        Text(user?.username ?? "")
                            .fontWeight(.semibold)
                        
                        Text(comment.timestamp.timestampString())
                            .foregroundColor(.gray)
                    }
                    
                    Text(comment.commentText)
                }
                .font(.caption)
                
                Spacer()
            }
            .navigationDestination(for: User.self, destination: { user in
                ProfileView(user: user)
            })
            .padding(.horizontal)
        }

    }
}

#Preview {
    CommentsCell(comment: DeveloperPreview.shared.comment)
}
