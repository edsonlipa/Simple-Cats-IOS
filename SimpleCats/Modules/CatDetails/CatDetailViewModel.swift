//
//  CatDetailViewModel.swift
//  SimpleCats
//
//  Created by Edson Lipa Urbina on 5/02/25.
//

import Foundation

class CatDetailViewModel: ObservableObject {
    @Published var cat: CatImage
    
    init(cat: CatImage) {
        self.cat = cat
    }
}
