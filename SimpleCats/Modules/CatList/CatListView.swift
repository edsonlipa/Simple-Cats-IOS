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
            Text(LocalizedStrings.CatList.title)
                
            List {
                ForEach(viewModel.images, id: \.id) { catImage in
                    NavigationLink(destination: {
                        CatDetailView(cat: catImage)
                    }, label: {
                        CatImageCell(image: catImage)
                    })
                    .buttonStyle(.plain)
                    .listRowSeparator(.hidden)
                    .accessibilityIdentifier(catImage.id)
                    .id(catImage.id)
                }
                
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .listRowSeparator(.hidden)
                }
            }
            .alert(item: $viewModel.error) { error in
                Alert(title: Text(LocalizedStrings.Common.error), message: Text(error.localizedDescription), dismissButton: .default(Text(LocalizedStrings.Common.ok)))
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
                    Image(ImageName.catPlaceholder)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .resizable()
                .scaledToFit()
                .overlay(alignment: .bottomLeading) {
                    HStack {
                        Text(image.breeds.first?.name ?? LocalizedStrings.Common.unknown)
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
                .accessibilityIdentifier(image.id)
                
        }
    }
}

#Preview {
    CatListView()
}
