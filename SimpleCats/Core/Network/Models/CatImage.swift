//
//  CatImage.swift
//  SimpleCats
//
//  Created by Edson Lipa Urbina on 6/02/25.
//

struct CatImage: Codable, Identifiable {
    let id: String
    let url: String
    let width: Int
    let height: Int
    let breeds: [CatBreed]
}
