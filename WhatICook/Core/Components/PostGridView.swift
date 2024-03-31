//
//  PostGridView.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 3/31/24.
//

import SwiftUI

struct PostGridView: View {
    
    var posts: [Post]
    
    private let gridItems: [GridItem] = [
        .init(.flexible(), spacing: 2),
        .init(.flexible(), spacing: 2),
        .init(.flexible(), spacing: 2)
    ]
    
    private let imageDimension: CGFloat = (UIScreen.main.bounds.width / 3) - 1
    
    
    var body: some View {
        LazyVGrid(columns: gridItems, spacing: 2) {
            ForEach(posts) { post in
                Image(post.imageURL)
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageDimension, height: imageDimension)
                    .clipped()
                    
            }
        }
        .padding(.top)
    }
}

#Preview {
    PostGridView(posts: Post.mockPost)
}
