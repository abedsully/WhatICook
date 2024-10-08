//
//  TabBarView.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 3/30/24.
//

import SwiftUI

struct TabBarView: View {
    let user: User
    
    
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                        .environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)
                    
                }
                .onAppear{selectedTab = 0}
                .tag(0)
            
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    
                }
                .onAppear {selectedTab = 1}
                .tag(1)
            
            UploadPostView(tabIndex: $selectedTab)
                .tabItem {
                    Image(systemName: "plus")
                }
                .onAppear{selectedTab = 2}
                .tag(2)
            
            NotificationsView()
                .tabItem {
                    Image(systemName: selectedTab == 3 ? "bell.fill" : "bell")
                        .environment(\.symbolVariants, selectedTab == 3 ? .fill : .none)
                }
                .onAppear{selectedTab = 3}
                .tag(3)
            
            CurrentUserProfileView(user: user)
                .tabItem {
                    Image(systemName: selectedTab == 4 ? "person.fill" : "person")
                        .environment(\.symbolVariants, selectedTab == 4 ? .fill : .none)
                }
                .onAppear{selectedTab = 4}
                .tag(4)
        }
        .tint(Constant.textColor)
        
    }
    
    var messageLink: some View {
        NavigationLink(
            destination: ConversationsView(),
            label: {
                Image(systemName: "paperplane")
                    .resizable()
                    .font(.system(size: 20, weight: .light))
                    .scaledToFit()
                    .foregroundColor(.black)
            })
    }
    
    
}

#Preview {
    TabBarView(user: User.mockUsers[0])
}

