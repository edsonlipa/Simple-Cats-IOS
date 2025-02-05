//
//  CatListView.swift
//  SimpleCats
//
//  Created by Edson Lipa Urbina on 5/02/25.
//

import SwiftUI

struct CatListView: View {
    @StateObject private var viewModel = CatListViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.images, id: \.id) { image in
                CatImageCell(image: image)

            }
            
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .listRowSeparator(.hidden)
            }
        }
        .task {
            await viewModel.refresh()
        }
    }
    
    func CatImageCell(image: CatImage) -> some View {
        Text(image.url)
    }
}

#Preview {
    CatListView()
}
