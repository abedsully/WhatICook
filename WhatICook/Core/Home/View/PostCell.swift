//
//  PostCell.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 3/30/24.
//

import SwiftUI
import Kingfisher

struct PostCell: View {
    @ObservedObject var viewModel: PostCellViewModel
    
    @State private var showComments = false
    
    private var post: Post {
        return viewModel.post
    }
    
    private var didLike: Bool {
        return post.didLike ?? false
    }
    
    init(post: Post) {
        self.viewModel = PostCellViewModel(post: post)
    }
    
    private var postLikes: Int {
        return post.likes
    }
    
    var body: some View {
        VStack {
            
            HStack() {
                if let user = post.user {
                    CircularProfileImageView(user: user, size: .xSmall)
                    
                    Text(user.username)
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(Constant.textColor)
                    
                }
                
                Spacer()
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 4)
            
            
            
            // Content Image
            KFImage(URL(string: post.imageURL))
                .resizable()
                .scaledToFill()
                .frame(height: 400)
                .clipShape(Rectangle())
            
            
            VStack (alignment: .center){
                Text(post.foodName)
                    .font(.title2)
                    .fontWeight(.semibold)
                Text(post.description)
                    .font(.caption)
            }
            .padding(.horizontal, 8)
            
            
            
            // Action Buttons
            HStack {
                
                Button {
                    likeButtonTapped()
                } label: {
                    Image(systemName: didLike ? "heart.fill" : "heart")
                        .imageScale(.large)
                        .foregroundColor(didLike ? .red : Constant.textColor)
                }
                
                Button {
                    showComments.toggle()
                } label: {
                    Image(systemName: "bubble.right")
                        .imageScale(.large)
                        .foregroundColor(Constant.textColor)
                }
                
                Button {
                    
                } label: {
                    Image(systemName: "eye")
                        .imageScale(.large)
                        .foregroundColor(Constant.textColor)
                    
                }
                
                Spacer()
                
                Text("Cooked: \(post.timestamp.timestampString()) ago")
                    .font(.footnote)
                    .foregroundStyle(Constant.textColor)
                
            }
            .padding(.horizontal, 10)
            .padding(.top, 6)
            
            if postLikes > 0 {
                Text("\(post.likes) likes")
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 14)
                    .padding(.top, 1)
                    .foregroundColor(Constant.textColor)
            }
        }
        .sheet(isPresented: $showComments, content: {
            CommentsView(post: post)
                .presentationDragIndicator(.visible)
        })
    }
    
    func likeButtonTapped() {
        Task {
            if didLike {
                try await viewModel.unlike()
            } else {
                try await viewModel.like()
            }
        }
    }
}


#Preview {
    PostCell(post: Post.mockPost[2])
}
