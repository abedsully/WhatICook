//
//  UserContentListView.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 4/8/24.
//

import SwiftUI
import Kingfisher

struct UserContentListView: View {
    
    @StateObject var viewModel: UserContentListViewModel
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: UserContentListViewModel(user: user))
    }
    
    @State private var selectedActivity: ProfileActivityFilter = .posts
    @Namespace var animation
    
    private let gridItems: [GridItem] = [
        .init(.flexible(), spacing: 2),
        .init(.flexible(), spacing: 2),
        .init(.flexible(), spacing: 2)
    ]
    
    private let imageDimension: CGFloat = (UIScreen.main.bounds.width / 3) - 1
    private var filterBarWidth: CGFloat {
        let count = CGFloat(ProfileActivityFilter.allCases.count)
        return UIScreen.main.bounds.width / count - 20
    }
    
    var body: some View {
        VStack {
            HStack {
                ForEach(ProfileActivityFilter.allCases) { activity in
                    VStack {
                        if activity == .posts {
                            Image(systemName: selectedActivity == activity ? "square.grid.3x3.fill" : "square.grid.3x3")
                                .fontWeight(selectedActivity == activity ? .semibold : .regular)
                                .environment(\.symbolVariants, selectedActivity == activity ? .fill : .none)
                        } else if activity == .likes {
                            Image(systemName: selectedActivity == activity ? "heart.fill" : "heart")
                                .fontWeight(selectedActivity == activity ? .semibold : .regular)
                                .environment(\.symbolVariants, selectedActivity == activity ? .fill : .none)
                        }
                        
                        
                        
                        if selectedActivity == activity {
                            Rectangle()
                                .foregroundColor(Constant.textColor)
                                .frame(width: filterBarWidth, height: 1)
                                .matchedGeometryEffect(id: "item", in: animation)
                        }
                        
                        else {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: filterBarWidth, height: 1)
                        }
                    }
                    .font(.title3)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            selectedActivity = activity
                        }
                        
                    }
                }
            }
            
            LazyVStack {
                switch selectedActivity {
                case .posts:
                    LazyVGrid(columns: gridItems, spacing: 2) {
                        ForEach(viewModel.posts) { post in
                            KFImage(URL(string: post.imageURL))
                                .resizable()
                                .scaledToFill()
                                .frame(width: imageDimension, height: imageDimension)
                                .clipped()
                            
                        }
                    }
                    .padding(.top)
                    
                case .likes:
                    //                    ForEach(viewModel.posts) { post in
                    //                        PostGridView(user: post.user ?? User.mockUsers[0])
                    //                    }
                    
                    Text("Hello")
                }
                
                
            }
        }
        .padding(.top, 8)
    }
}

#Preview {
    UserContentListView(user: User.mockUsers[0])
}
