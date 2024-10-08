//
//  ImageUploader.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 4/6/24.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage

struct ImageUploader {
    static func uploadImage(image: UIImage) async throws -> String?{
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {return nil}
        let filename = NSUUID().uuidString
        let reference = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        do {
            let _ = try await reference.putDataAsync(imageData)
            let url = try await reference.downloadURL()
            return url.absoluteString
        } catch {
            print("DEBUG: Failed to upload image with error \(error.localizedDescription)")
            return nil
        }
        
    }
}
