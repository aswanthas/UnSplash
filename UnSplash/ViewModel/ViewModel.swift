//
//  ViewModel.swift
//  UnSplash
//
//  Created by Aswanth K on 02/07/24.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    @Published var response: [ImageResponse] = []
    @Published var page = 1
    @Published var errorMessage: String? = nil
    @Published var showAlert: Bool = false
    
    private var cancellable = Set<AnyCancellable>()
    
    func fetchData(page: Int?) {
        let api = ApiEndPoint.getMainList(page ?? self.page, 20)
        NetworkManager.shared.fetchData(api: api)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                if case let .failure(error) = completion {
                    self.errorMessage = error.localizedDescription
                    self.showAlert = true
                }
            }, receiveValue: { [weak self] (response: [ImageResponse]) in
                guard let self = self else { return }
                let newresponse = response
                if page == 1 {
                    self.response = newresponse
                } else {
                    self.response.append(contentsOf: newresponse)
                }
            })
            .store(in: &cancellable)
    }
    
    func loadNextPage() {
        page += 1
        fetchData(page: page)
    }
    
    func refresh() {
        page = 1
        response.removeAll()
        fetchData(page: page)
    }
}
