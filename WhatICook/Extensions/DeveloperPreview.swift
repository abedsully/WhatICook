//
//  DeveloperPreview.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 4/13/24.
//

import SwiftUI
import Firebase

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.shared
    }
}

class DeveloperPreview {
    static let shared = DeveloperPreview()
    
    let comment = Comments(postOwnerUid: "123", commentText: "Test comment", postId: "123", timestamp: Timestamp(), commentOwnerUid: "1232")
}
