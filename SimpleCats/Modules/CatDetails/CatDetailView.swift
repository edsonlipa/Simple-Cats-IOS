//
//  CatDetailView.swift
//  SimpleCats
//
//  Created by Edson Lipa Urbina on 5/02/25.
//

import SwiftUI
import Kingfisher

struct CatDetailView: View {
    @StateObject var viewModel: CatDetailViewModel
    
    init(cat: CatImage) {
        self._viewModel = .init(wrappedValue: .init(cat: cat))
    }
    
    var body: some View {
        VStack {
            if let url = URL(string: viewModel.cat.url)  {
                KFImage(url)
                    .placeholder {
                        Image("cat-placeholder")
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 16)
                
            }
            ScrollView {
                ForEach(viewModel.cat.breeds, id: \.self) { breed in
                    CatBreedView(breed: breed)
                }
            }
        }
        .navigationTitle(Text("The Cat: \(viewModel.cat.id)"))
        .padding(16)
    }
}

#Preview {
    CatDetailView(cat: .init(id: "1", url: "https://example.com/image.jpg", width: 100, height: 100, breeds: []))
}

struct CatBreedView: View {
    let breed: CatBreed
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 8) {
                Text(breed.name)
                    .font(.largeTitle)
                    .bold()
                
                Text("Origin: \(breed.origin)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("About")
                    .font(.headline)
                
                Text(breed.description)
                    .font(.body)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Temperament")
                    .font(.headline)
                
                Text(breed.temperament)
                    .font(.body)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Details")
                    .font(.headline)
                
                HStack(alignment: .top) {
                    Text("Life Span")
                        .foregroundColor(.secondary)
                        .frame(width: 100, alignment: .leading)
                    Text("\(breed.lifeSpan) years")
                }
            }
            
            if let wikipediaUrl = breed.wikipediaUrl,
               let url = URL(string: wikipediaUrl) {
                Link(destination: url) {
                    HStack {
                        Text("Read more on Wikipedia")
                        Image(systemName: "link")
                    }
                    .foregroundColor(.blue)
                }
            }
        }
        .padding()
    }
}
