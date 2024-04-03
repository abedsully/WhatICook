//
//  ContentView.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 3/30/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    @StateObject var registrationViewModel = RegistrationViewModel()
    
    var body: some View {
        Group {
            if viewModel.userSession == nil {
                LoginView()
                    .environmentObject(registrationViewModel)
            }
            
            else if let currentUser = viewModel.currentUser {
                TabBarView(user: currentUser)
            }
        }
    }
}

#Preview {
    ContentView()
}
