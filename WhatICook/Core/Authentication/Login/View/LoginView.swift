//
//  LoginView.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 3/31/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @StateObject var viewModel =  LoginViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Spacer()
                
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220, height: 220)
                
                VStack (spacing: 15){
                    TextField("Enter your email", text: $viewModel.email)
                        .autocapitalization(.none)
                        .modifier(TextFieldModifier())
                    
                    SecureField("Enter your password", text: $viewModel.password)
                        .modifier(TextFieldModifier())
                }
                
                Button {
                    print("Forget Password")
                } label: {
                    Text("Forget Password?")
                        .font(.footnote)
                        .foregroundColor(Constant.mainColor)
                        .fontWeight(.semibold)
                        .padding(.top)
                        .padding(.trailing, 28)
                    
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                Button {
                    Task { try await viewModel.login() }
                } label: {
                    Text("Login")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 350, height: 44)
                        .background(Constant.mainColor)
                        .cornerRadius(8)
                }
                .padding(.vertical)
                
                
                Spacer()
                
                Divider()
                
                NavigationLink {
                    RegisterEmailView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack {
                        Text("Don't have an account?")
                            .foregroundColor(Constant.textColor)
                        
                        Text("Sign up")
                            .fontWeight(.semibold)
                            .foregroundColor(Constant.mainColor)
                    }
                    .font(.footnote)
                }
                .padding(.vertical, 16)
            }
        }
    }
}

#Preview {
//    LoginView()
    LoginView().preferredColorScheme(.dark)

}
