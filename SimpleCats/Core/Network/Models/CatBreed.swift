//
//  CatBreed.swift
//  SimpleCats
//
//  Created by Edson Lipa Urbina on 6/02/25.
//

struct CatBreed: Codable, Hashable {
    let id: String
    let name: String
    let description: String
    let temperament: String
    let origin: String
    let lifeSpan: String
    let wikipediaUrl: String?
}
