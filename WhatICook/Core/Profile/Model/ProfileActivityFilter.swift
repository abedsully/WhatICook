//
//  ProfileActivityFilter.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 4/8/24.
//

import Foundation

enum ProfileActivityFilter: Int, CaseIterable, Identifiable {
    case posts
    case likes
    
    var title: String {
        switch self {
        case .posts: return "Posts"
        case .likes: return "Likes"
        }
    }
    
    var id: Int? {return self.rawValue}
}
