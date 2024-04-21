//
//  MessageViewModel.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 4/21/24.
//

import Firebase

struct MessageViewModel {
    let message: Message
    
    var currentUid: String { return Auth.auth().currentUser?.uid ?? "" }
    
    var isFromCurrentUser: Bool { return message.fromId == currentUid }
}
