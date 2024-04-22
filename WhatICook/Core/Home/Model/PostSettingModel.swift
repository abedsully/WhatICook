//
//  PostSettingModel.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 4/22/24.
//

import Foundation

enum PostSettingModel: Int, Identifiable, Hashable, CaseIterable {
    case delete
    
    var title: String {
        switch self {
        case .delete:
            return "Delete Post"
        }
    }
    
    var imageName: String {
        switch self {
        case .delete:
            return "trash"
        }
    }
    
    var id: Int {return self.rawValue}
}
