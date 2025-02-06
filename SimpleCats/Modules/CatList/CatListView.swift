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
        NavigationStack {
            List {
                ForEach(viewModel.images, id: \.id) { catImage in
                    NavigationLink(destination: {
                        CatDetailView(cat: catImage)
                    }, label: {
                        CatImageCell(image: catImage)
                    })
                    .buttonStyle(.plain)
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
                await viewModel.onAppear()
            }
            .refreshable {
                await viewModel.refresh()
            }
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
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .resizable()
                .scaledToFit()
                .overlay(alignment: .bottomLeading) {
                    HStack {
                        Text("\(image.breeds.first?.name ?? "Unknown")")
                            .foregroundColor(.white)
                            .padding(.all, 4)
                    }
                    .background(Color.black.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .padding()
                }
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(radius: 10)
                .onAppear {
                    viewModel.loadMoreIfNeeded(currentItem: image)
                }
        }
    }
}

#Preview {
    CatListView()
}
