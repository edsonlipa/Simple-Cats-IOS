//
//  CatListViewModel.swift
//  SimpleCats
//
//  Created by Edson Lipa Urbina on 5/02/25.
//

import Foundation

class CatListViewModel: ObservableObject {
    @Published private(set) var images: [CatImage] = []
    @Published private(set) var isLoading = false
    @Published var error: Error?
    
    private let networkManager: NetworkProtocol
    private var currentPage = 0
    
    init(networkManager: NetworkProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func loadMoreIfNeeded(currentItem: CatImage?) {
        guard let currentItem = currentItem,
              let lastItem = images.last,
              currentItem.id == lastItem.id,
              !isLoading
        else { return }
        
        Task { await loadMore() }
    }
    
    @MainActor
    func refresh() async {
        currentPage = 0
        images = []
        await loadMore()
    }
    
    func onAppear() async {
        guard images.isEmpty else { return }
        
        await loadMore()
    }
    
    @MainActor
    private func loadMore() async {
        guard !isLoading else { return }
        
        isLoading = true
        
        do {
            let newImages: [CatImage] = try await fetchImages(page: currentPage)
            currentPage += 1
            images.append(contentsOf: newImages)
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
    
    // here we can add filters if nedded
    private func fetchImages(page: Int = 0) async throws -> [CatImage] {
        return try await networkManager.request(TheCatAPI.images(limit: 10, page: page))
    }
}
