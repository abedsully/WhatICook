//
//  PostFoodCategory.swift
//  WhatICook
//
//  Created by Stefanus Albert Wilson on 3/31/24.
//

import Foundation

enum FoodCategory: String, CaseIterable, Identifiable {
    case snack = "Snack"
    case pasta = "Pasta & Noodles"
    case international = "International Cuisines"
    case chicken = "Chicken"
    case vegan = "Vegan"
    case barbecue = "Barbecue"
    case beverages = "Dessert & Beverages"
    case breakfast = "Breakfast"
    case seafood = "Seafood"
    case sushi = "Sushi"
    case others = "Others"
    
    var id: String { rawValue }
}
