//
//  CompleteRegisterView.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 3/31/24.
//

import SwiftUI

struct CompleteRegisterView: View {
    @EnvironmentObject var viewModel: RegistrationViewModel
    
    var body: some View {
        VStack (spacing: 16){
            
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 220, height: 220)
            
            Text("Welcome to WhatICook, \(viewModel.username)")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(Constant.mainColor)
                .multilineTextAlignment(.center)
            
            Text("We're very glad to welcome you to WhatICook, Press the button below to continue")
                .font(.footnote)
                .padding(.horizontal, 24)
                .multilineTextAlignment(.center)
                .foregroundColor(Constant.textColor)
            
            Button {
                Task { try await viewModel.createUser() }
            } label: {
                Text("To home page")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 350, height: 44)
                    .background(Constant.mainColor)
                    .cornerRadius(8)
            }
        }
    }
}

#Preview {
    CompleteRegisterView()
}
