//
//  UploadPostViewModel.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 3/31/24.
//

import Foundation
import SwiftUI
import PhotosUI

@MainActor
class UploadPostViewModel: ObservableObject {
    
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task { try await loadImage(fromItem: selectedImage) } }
    }
    
    @Published var postImage: Image?
    
    func loadImage(fromItem item: PhotosPickerItem?) async throws {
        
        // taking from the parameter item, else return
        guard let item = item else { return }
        
        // getting the data from the item (image) that we get from top
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        
        // create uiImage from UIKit, using that data we get from top
        guard let uiImage = UIImage(data: data) else { return }
        
        // create SwiftUI using that uiImage
        self.postImage = Image(uiImage: uiImage)
    }
}
