//
//  UploadPostViewModel.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 3/31/24.
//

import Foundation
import SwiftUI
import PhotosUI
import Firebase

@MainActor
class UploadPostViewModel: ObservableObject {
    
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task { try await loadImage(fromItem: selectedImage) } }
    }
    
    @Published var postImage: Image?
    
    private var uiImage: UIImage?
    
    func loadImage(fromItem item: PhotosPickerItem?) async throws {
        
        // taking from the parameter item, else return
        guard let item = item else { return }
        
        // getting the data from the item (image) that we get from top
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        
        // create uiImage from UIKit, using that data we get from top
        guard let uiImage = UIImage(data: data) else { return }
        
        self.uiImage = uiImage
        
        // create SwiftUI using that uiImage
        self.postImage = Image(uiImage: uiImage)
    }
    
    func uploadPost(foodName: String, category: String, description: String, ingredients: String, instructions: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let uiImage = uiImage else {return}
        
        guard let imageURL = try await ImageUploader.uploadImage(image: uiImage) else {return}
        
        let postRef = Firestore.firestore().collection(Constant.postCollection).document()
        
        let post = Post(id: postRef.documentID, ownerUid: uid, likes: 0, comments: 0, foodName: foodName, category: category, description: description, ingredients: ingredients, instructions: instructions, imageURL: imageURL, timestamp: Timestamp())
        
        guard let encodedPost = try? Firestore.Encoder().encode(post) else {return}
        
        try await postRef.setData(encodedPost)
        
        
    }
}
