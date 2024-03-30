//
//  HomeView.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 3/30/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack (spacing: 28){
                    ForEach(0 ... 15, id: \.self) { post in
                        PostCell()
                    }
                }
                .padding(.vertical, 15)
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
                    Image(systemName: "paperplane")
                        .imageScale(.large)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
