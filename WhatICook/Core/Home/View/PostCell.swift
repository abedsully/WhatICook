//
//  PostCell.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 3/30/24.
//

import SwiftUI
import Kingfisher
import Firebase

struct PostCell: View {
    @ObservedObject var viewModel: PostCellViewModel
    
    @State private var showComments = false
    @State private var showDetail = false
    
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
    
    private var currentUid: String? {
        return Auth.auth().currentUser?.uid
    }
    
    @State private var showPostOption = false
    @State private var selectedOption: PostSettingModel?
    @State private var showDetails = false
    
    var body: some View {
        VStack {
            
            HStack(alignment: .center) {
                NavigationLink(value: post.user) {
                    if let user = post.user {
                        CircularProfileImageView(user: user, size: .xSmall)
                        
                        Text(user.username)
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundColor(Constant.textColor)
                    }
                }
                .navigationDestination(for: User.self) { user in
                    ProfileView(user: user)
                }
                
                Spacer()
                
                
                if currentUid == post.ownerUid {
                    Button {
                        showPostOption.toggle()
                    } label: {
                        Image(systemName: "ellipsis")
                            .imageScale(.medium)
                    }
                    .sheet(isPresented: $showPostOption, content: {
                        PostSettingView(selectedOption: $selectedOption)
                            .presentationDetents([.height(CGFloat(SettingsModel.allCases.count * 56))])
                            .presentationDragIndicator(.visible)
                    })
                    .onChange(of: selectedOption) { newValue in
                        guard let option = newValue else { return }
                        
                        if option == .delete {
                            Task {
                                try await viewModel.deletePost()
                            }
                        }
                    }
                    
                }
                
                
                
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
                    showDetail.toggle()
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
            
            
            NavigationLink(value: UserListConfig.likes(postId: post.id)) {
                if postLikes > 0 {
                    Text("\(post.likes) likes")
                        .font(.footnote)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 14)
                        .padding(.top, 1)
                        .foregroundColor(Constant.textColor)
                }
            }
            .navigationDestination(for: UserListConfig.self) { config in
                UserListView(config: config)
            }
            
            if post.comments > 0 {
                Button {
                    showComments.toggle()
                } label: {
                    
                    Text("\(post.comments) comments")
                        .font(.footnote)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 14)
                        .padding(.top, 1)
                        .foregroundStyle(.gray)
                    
                }
            }
            
            
        }
        .sheet(isPresented: $showComments, content: {
            CommentsView(post: post)
                .presentationDragIndicator(.visible)
        })
        
        .sheet(isPresented: $showDetail, content: {
            PostDetailView(post: post)
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
