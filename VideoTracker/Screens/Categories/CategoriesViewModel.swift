//
//  CategoriesViewModel.swift
//  VideoTracker
//
//  Created by Татьяна Севостьянова on 18.07.2020.
//  Copyright © 2020 Татьяна Севостьянова. All rights reserved.
//

import UIKit

class CategoriesViewModel {
    
    var listImages: [Item] = []
    
    func loadData() {
        
        listImages = [
            Item(image: .item1, name: "BMV"),
            Item(image: .item4, name: "Ferrari"),
            Item(image: .item2, name: "Audio"),
            Item(image: .item5, name: "Lexus"),
            Item(image: .item3, name: "Mercedes"),
            Item(image: .item6, name: "Lamborgini"),
            Item(image: .item1, name: "BMV"),
            Item(image: .item4, name: "Ferrari"),
            Item(image: .item2, name: "Audio"),
            Item(image: .item5, name: "Lexus"),
            Item(image: .item3, name: "Mercedes"),
            Item(image: .item6, name: "Lamborgini")
        ]
    }
}
