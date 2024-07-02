//
//  NetworkManager.swift
//  UnSplash
//
//  Created by Aswanth K on 02/07/24.
//

import Foundation
import Combine

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    func fetchData<T: Decodable>(api: ApiEndPoint) -> AnyPublisher<T, Error> {
        guard let urlString = URL(string: api.urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: urlString)
            .map(\.data)
            .handleEvents(receiveOutput: { data in
                if let jsonStr = String(data: data, encoding: .utf8) {
                    print("Raw JSON response: \(jsonStr)")
                }
            })
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
