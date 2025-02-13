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
                        Image(ImageName.catPlaceholder)
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
        .navigationTitle(Text(LocalizedStrings.CatDetail.title))
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
                
                Text(LocalizedStrings.CatDetail.originWithCountry(breed.origin))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(LocalizedStrings.CatDetail.about)
                    .font(.headline)
                
                Text(breed.description)
                    .font(.body)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(LocalizedStrings.CatDetail.temperament)
                    .font(.headline)
                
                Text(breed.temperament)
                    .font(.body)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(LocalizedStrings.CatDetail.details)
                    .font(.headline)
                
                HStack(alignment: .top) {
                    Text(LocalizedStrings.CatDetail.lifeSpan)
                        .foregroundColor(.secondary)
                        .frame(width: 100, alignment: .leading)
                    Text(LocalizedStrings.CatDetail.lifeSpan(with: breed.lifeSpan))
                }
            }
            
            if let wikipediaUrl = breed.wikipediaUrl,
               let url = URL(string: wikipediaUrl) {
                Link(destination: url) {
                    HStack {
                        Text(LocalizedStrings.CatDetail.readMore)
                        Image(systemName: SystemIconName.link)
                    }
                    .foregroundColor(.blue)
                }
            }
        }
        .padding()
    }
}
