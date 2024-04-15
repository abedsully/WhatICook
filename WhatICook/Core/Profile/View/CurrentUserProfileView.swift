//
//  CurrentUserProfileView.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 3/31/24.
//

import SwiftUI

struct CurrentUserProfileView: View {
    
    let user: User
    
    var posts: [Post] {
        return Post.mockPost.filter({ $0.user?.username == user.username })
    }
    
    @State private var showSettingsSheet = false
    @State private var selectedSettingsOption: SettingsModel?
    @State private var showDetail = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                // Header View
                ProfileHeaderView(user: user)
                
                // Grid View
                UserContentListView(user: user)
            }
            .navigationTitle(user.username)
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $showDetail, destination: {
                Text(selectedSettingsOption?.title ?? "")
            })
            .sheet(isPresented: $showSettingsSheet, content: {
                SettingsView(selectedOption: $selectedSettingsOption)
                    .presentationDetents([.height(CGFloat(SettingsModel.allCases.count * 56))])
                    .presentationDragIndicator(.visible)
            })
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        selectedSettingsOption = nil
                        showSettingsSheet.toggle()
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(Constant.textColor)
                    }
                    
                }
            }
            .onChange(of: selectedSettingsOption) { newValue in
                guard let option = newValue else { return }
                
                if option != .logout {
                    self.showDetail.toggle()
                } else {
                    AuthService.shared.signOut()
                }
            }
        }
    }
}
#Preview {
    CurrentUserProfileView(user: User.mockUsers[0])
}
