//
//  ProfileView.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 3/30/24.
//

import SwiftUI

struct ProfileView: View {
    
    private let gridItems: [GridItem] = [
        .init(.flexible(), spacing: 2),
        .init(.flexible(), spacing: 2),
        .init(.flexible(), spacing: 2)
    ]
    var body: some View {
        NavigationStack {
            ScrollView {
                // Header View
                VStack (spacing: 10){
                    
                    // Profile Picture and Status
                    HStack {
                        Image(Constant.profilePicture)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                        
                        Spacer()

                        UserStatusView(value: 5, description: "Posts")
                        UserStatusView(value: 12, description: "Followers")
                        UserStatusView(value: 24, description: "Followings")
                        
                        
                    }
                    .padding(.horizontal)

                    // Name and Bio
                    VStack (alignment: .leading){
                        Text("Stefanus Albert Wilson")
                            .fontWeight(.semibold)
                        Text("Professional Chef")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .font(.footnote)

                    // Action Button
                    Button {
                        // Button action code
                    } label: {
                        Text("Edit Profile")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(Constant.textColor)
                            .frame(width: 360, height: 32)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Constant.mainColor, lineWidth: 1)
                            )
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Constant.mainColor)
                            )
                    }
                    
                    Divider()
                }
                .padding(.top)
                
                // Grid View
                LazyVGrid(columns: gridItems, spacing: 2) {
                    ForEach(0 ... 15, id: \.self) { index in
                        Image(Constant.profilePicture)
                            .resizable()
                            .scaledToFill()
                    }
                }
            }            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("logo")
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(Constant.textColor)
                    }

                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
