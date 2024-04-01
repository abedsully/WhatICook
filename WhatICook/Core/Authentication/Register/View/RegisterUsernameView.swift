//
//  RegisterUsernameView.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 3/31/24.
//

import SwiftUI

struct RegisterUsernameView: View {
    @Environment (\.dismiss) var dismiss
    @EnvironmentObject var viewModel: RegistrationViewModel
    
    var body: some View {
        VStack (spacing: 12){
            Text("Create username")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(Constant.mainColor)
            
            Text("Pick a username for your new account, You can always change it later")
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(.horizontal, 24)
                .multilineTextAlignment(.center)
            
            TextField("Enter your username", text: $viewModel.username)
                .autocapitalization(.none)
                .modifier(TextFieldModifier())
                .padding(.top)
            
            NavigationLink {
                RegisterPasswordView()
                    .navigationBarBackButtonHidden()
            } label: {
                Text("Next")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 350, height: 44)
                    .background(Constant.mainColor)
                    .cornerRadius(8)
            }
            .padding(.vertical)
            
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .onTapGesture {
                        dismiss()
                    }
            }
        }
    }
}

#Preview {
    RegisterUsernameView()
}
