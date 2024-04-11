//
//  PostCell.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 3/30/24.
//

import SwiftUI
import Kingfisher

struct PostCell: View {
    let post: Post
    
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
            
            
            VStack (alignment: .leading){
                Text("Delicious Pasta")
                    .font(.title2)
                    .fontWeight(.semibold)
                Text("Classic Italian dish with tomatoes and noodles, it is so great you should make it")
                    .font(.caption)
            }
            .padding(.horizontal, 8)
            
            
            
            // Action Buttons
            HStack {
                
                Button {
                    
                } label: {
                    Image(systemName: "heart")
                        .imageScale(.large)
                        .foregroundColor(Constant.textColor)
                }
                
                Button {
                    
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
                
                Text("Cooked 2 hours ago")
                    .font(.footnote)
                    .foregroundStyle(Constant.textColor)
                
            }
            .padding(.horizontal, 10)
            .padding(.top, 6)
            
            Text("\(post.likes) likes")
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 14)
                .padding(.top, 1)
                .foregroundColor(Constant.textColor)
            
        }
    }
}


#Preview {
    PostCell(post: Post.mockPost[2])
}
