//
//  CatListView.swift
//  SimpleCats
//
//  Created by Edson Lipa Urbina on 5/02/25.
//

import SwiftUI
import Kingfisher

struct CatListView: View {
    @StateObject private var viewModel = CatListViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.images, id: \.id) { image in
                CatImageCell(image: image)
                    .listRowSeparator(.hidden)
            }
            
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .task {
            await viewModel.refresh()
        }
    }
    
    @ViewBuilder
    func CatImageCell(image: CatImage) -> some View {
        if let url = URL(string: image.url) {
            KFImage(url)
                .placeholder {
                    Image("cat-placeholder")
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .resizable()
                .roundCorner(radius: .heightFraction(0.05))
                .scaledToFit()
                .overlay(alignment: .bottomLeading) {
                    HStack {
                        Text("\(image.id)")
                            .foregroundColor(.white)
                            .padding(.all, 4)
                    }
                    .background(Color.black.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding()
                }
                .shadow(radius: 5)
        }
    }
}

#Preview {
    CatListView()
}
