//
//  MessageView.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 4/21/24.
//

import SwiftUI
import Kingfisher

struct MessageView: View {
    let viewModel: MessageViewModel
    
    var body: some View {
        HStack {
            if viewModel.isFromCurrentUser {
                Spacer()
                Text(viewModel.message.text)
                    .font(.system(size: 15))
                    .padding(10)
                    .background(Color.blue)
                    .clipShape(ChatBubble(isFromCurrentUser: true))
                    .foregroundStyle(.white)
                    .padding(.leading, 100)
                    .padding(.trailing)
            } else {
                HStack(alignment: .bottom) {
                    CircularProfileImageView(user: viewModel.message.user, size: .xSmall)
                    
                    Text(viewModel.message.text)
                        .font(.system(size: 15))
                        .padding(10)
                        .background(Constant.mainColor)
                        .clipShape(ChatBubble(isFromCurrentUser: false))
                        .foregroundStyle(.black)
                }
                .padding(.trailing, 100)
                .padding(.leading)
                
                Spacer()
            }
        }
    }
}
