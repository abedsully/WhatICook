//
//  PostCell.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 3/30/24.
//

import SwiftUI

struct PostCell: View {
    var body: some View {
        VStack {
            // Content Credentials
            HStack (alignment: .center){
                Image(Constant.profilePicture)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
                Text("abedsully")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundColor(Constant.textColor)
                
                Spacer()
                
                Text("6h ago")
                    .font(.footnote)
                    .foregroundColor(Constant.textColor)
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 4)
            
            // Content Image
            Image(Constant.profilePicture)
                .resizable()
                .scaledToFill()
                .frame(height: 400)
                .clipShape(Rectangle())
            
            // Content Caption
            Text("Fried Rice with Hamburger")
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
                
                Button {
                    
                } label: {
                    Image(systemName: "paperplane")
                        .imageScale(.large)
                        .foregroundColor(Constant.textColor)
                        
                }
                
                Spacer()
            }
            .padding(.leading, 8)
            .padding(.top, 2)
            
            Text("23 Likes")
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 10)
                .padding(.top, 1)
                .foregroundColor(Constant.textColor)
            

            
        }
    }
}

#Preview {
    PostCell()
}
