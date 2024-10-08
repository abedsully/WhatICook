//
//  HomeView.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 3/30/24.
//

import SwiftUI


struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack (spacing: 28){
                    ForEach(viewModel.posts) { post in
                        PostCell(post: post)
                    }
                }
                .padding(.vertical, 15)
            }
            .refreshable {
                Task {
                    try await viewModel.fetchPosts()
                }
            }
            .navigationTitle("WhatICook")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("logo")
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(
                        destination: ConversationsView(),
                        label: {
                            Image(systemName: "paperplane")
                                .imageScale(.large)
                                .scaledToFit()
                                .foregroundColor(Constant.textColor)
                        })
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
