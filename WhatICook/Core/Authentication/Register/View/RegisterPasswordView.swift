//
//  RegisterPasswordView.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 3/31/24.
//

import SwiftUI

struct RegisterPasswordView: View {
    @State private var password = ""
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        VStack (spacing: 12){
            Text("Create password")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(Constant.mainColor)
            
            Text("Please enter a password for at least 8 characters")
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(.horizontal, 24)
                .multilineTextAlignment(.center)
            
            SecureField("Enter your password", text: $password)
                .autocapitalization(.none)
                .modifier(TextFieldModifier())
                .padding(.top)
            
            NavigationLink {
                CompleteRegisterView()
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
    RegisterPasswordView()
}
