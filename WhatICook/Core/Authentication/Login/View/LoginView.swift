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
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Spacer()
                
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220, height: 220)
                
                VStack (spacing: 15){
                    TextField("Enter your email", text: $email)
                        .autocapitalization(.none)
                        .modifier(TextFieldModifier())
                    
                    SecureField("Enter your password", text: $password)
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
                    print("Login")
                } label: {
                    Text("Login")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(Constant.textColor)
                        .frame(width: 350, height: 44)
                        .background(Constant.mainColor)
                        .cornerRadius(8)
                }
                .padding(.vertical)
                
                
                Spacer()
                
                Divider()
                
                NavigationLink {
                    Text("Sign up")
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
    LoginView()
}
