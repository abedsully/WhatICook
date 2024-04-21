//
//  UserCell.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 4/21/24.
//

import SwiftUI
import Kingfisher

struct UserCell: View {
    let user: User
    
    var body: some View {
        HStack(spacing: 12) {
            CircularProfileImageView(user: user, size: .small)
            
            VStack(alignment: .leading) {
                Text(user.username)
                    .font(.system(size: 14, weight: .semibold))
                
                if let fullname = user.fullName {
                    Text(fullname)
                        .font(.system(size: 14))
                }
            }.foregroundColor(Constant.textColor)
            
            Spacer()
        }
    }
}
