//
//  PostDetailView.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 4/22/24.
//

import SwiftUI
import Kingfisher

struct PostDetailView: View {
    @ObservedObject var viewModel: PostDetailViewModel
    
    init(post: Post) {
        self.viewModel = PostDetailViewModel(post: post)
    }
    
    private var post: Post {
        return viewModel.post
    }
    
    var body: some View {
        
        ScrollView {
            VStack (alignment: .leading, spacing: 15){
                KFImage(URL(string: post.imageURL))
                    .resizable()
                    .frame(height: 300)
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                HStack {
                    VStack (alignment: .leading){
                        Text(post.foodName)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(post.category)
                            .font(.headline)
                            .foregroundStyle(.gray)
                            .fontWeight(.semibold)
                    }
                    
                    Spacer()
                    
                    if viewModel.didLike {
                        Image(systemName: "heart.fill")
                            .foregroundStyle(.red)
                    }
                }
                
                
                Text(post.description)
                    .font(.subheadline)
                
                
                
                VStack (alignment: .leading){
                    Text("Ingredients")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Text("• " + post.instructions.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces).capitalized }.joined(separator: "\n• "))
                        .font(.subheadline)
                }
                .font(.subheadline)
                
                VStack (alignment: .leading){
                    Text("Instructions")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Text("• " + post.instructions.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces).capitalized }.joined(separator: "\n• "))
                        .font(.subheadline)
                }
                .font(.subheadline)
                
                
            }
            .multilineTextAlignment(.leading)
            .padding(20)
        }
        
        
    }
}
