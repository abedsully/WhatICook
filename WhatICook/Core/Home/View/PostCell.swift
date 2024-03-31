//
//  PostCell.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 3/30/24.
//

import SwiftUI

struct PostCell: View {
    let post: Post
    
    var body: some View {
        VStack {
            // Content Credentials
            HStack (alignment: .center){
                if let user = post.user {
                    Image(user.profileImageURL ?? "")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                    
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
            Image(post.imageURL)
                .resizable()
                .scaledToFill()
                .frame(height: 400)
                .clipShape(Rectangle())
            
            // Content Caption
            Text(post.foodName)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 2)
                .fontWeight(.semibold)
                .font(.title3)
            
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
            

            
        }
    }
}

#Preview {
    PostCell(post: Post.mockPost[2])
}
