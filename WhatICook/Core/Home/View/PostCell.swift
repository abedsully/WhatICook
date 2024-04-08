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
            VStack {
                // Content Credentials
                HStack (alignment: .center){
                    if let user = post.user {
                        CircularProfileImageView(user: user, size: .xSmall)
                        
                        Text(user.username)
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundColor(Constant.textColor)
                    }
                    
                    Spacer()
                    
                    Text("\(post.timestamp)")
                        .font(.footnote)
                        .foregroundColor(Constant.textColor)
                }
                .padding(.horizontal, 8)
                .padding(.bottom, 4)
                
                // Content Image
                KFImage(URL(string: post.imageURL))
                    .resizable()
                    .scaledToFill()
                    .frame(height: 400)
                    .clipShape(Rectangle())
                
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
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "eye")
                            .imageScale(.large)
                            .foregroundColor(Constant.textColor)
                        
                    }
                    
                }
                .padding(.horizontal, 8)
                .padding(.top, 2)
                
                Text("\(post.likes) likes")
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 10)
                    .padding(.top, 1)
                    .foregroundColor(Constant.textColor)
                
                HStack {
                    Text(post.user?.username ?? "").fontWeight(.semibold) + Text(" ") + Text(post.description)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.footnote)
                .padding(.leading, 10)
                .padding(.top, 1)
            }
        }
        .clipShape(Rectangle())
        .padding(10)
        .background(.gray)
    }
}

#Preview {
    PostCell(post: Post.mockPost[2])
}
