//
//  UploadPostView.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 3/31/24.
//

import SwiftUI
import PhotosUI

struct UploadPostView: View {
    
    @State private var foodName = ""
    @State private var category: FoodCategory = .snack
    @State private var description = ""
    @State private var ingredients = ""
    @State private var directions = ""
    @State private var imagePickerPresented = false
    @StateObject var viewModel = UploadPostViewModel()
    @Binding var tabIndex: Int
    
    var body: some View {
        // Action Button
        VStack {
            HStack (){
                Button {
                    foodName = ""
                    category = .snack
                    description = ""
                    ingredients = ""
                    directions = ""
                    viewModel.selectedImage = nil
                    viewModel.postImage = nil
                    tabIndex = 0
                } label: {
                    Image(systemName: "multiply")
                        .imageScale(.large)
                    
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("New Post")
                        .fontWeight(.semibold)
                }
                .padding(.leading, 15)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Post")
                        .fontWeight(.semibold)
                }
            }
            .foregroundColor(Constant.textColor)
            .padding(.horizontal)
            
            ScrollView {
                VStack (spacing: 20){
                    if let image = viewModel.postImage {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: 250)
                            .clipped()
                            .padding(.vertical, 12)
                    }

                    VStack (alignment: .leading){
                        Text("Food Name")
                            .foregroundColor(Constant.textColor)
                            .padding(.horizontal, 25)
                        TextField("Enter Food Name", text: $foodName, axis: .vertical)
                            .modifier(TextFieldModifier())
                    }
                    
                    HStack (){
                        Text("Category")
                            .foregroundColor(Constant.textColor)
 
                        Spacer()
                        
                        Picker("Category", selection: $category) {
                            ForEach(FoodCategory.allCases, id: \.self) { category in
                                Text(category.rawValue)
                            }
                        }
                        .pickerStyle(.menu)
                        .padding(.horizontal, 12)
                    }
                    .modifier(TextFieldModifier())
                    
                    VStack (alignment: .leading){
                        Text("Description")
                            .foregroundColor(Constant.textColor)
                            .padding(.horizontal, 25)
                        TextField("Enter Food Description", text: $description, axis: .vertical)
                            .modifier(TextFieldModifier())
                    }
                    
                    VStack (alignment: .leading){
                        Text("Ingredients")
                            .foregroundColor(Constant.textColor)
                            .padding(.horizontal, 25)
                        TextField("Enter Food Ingredients", text: $ingredients, axis: .vertical)
                            .modifier(TextFieldModifier())
                    }
                    
                    VStack (alignment: .leading){
                        Text("Directions")
                            .foregroundColor(Constant.textColor)
                            .padding(.horizontal, 25)
                        TextField("Enter Cooking Directions", text: $directions, axis: .vertical)
                            .modifier(TextFieldModifier())
                    }
                    
                }
                
            }
            .onAppear {
                imagePickerPresented.toggle()
            }
        }
        .photosPicker(isPresented: $imagePickerPresented, selection: $viewModel.selectedImage)
        
    }
}

#Preview {
    UploadPostView(tabIndex: .constant(0))
}
