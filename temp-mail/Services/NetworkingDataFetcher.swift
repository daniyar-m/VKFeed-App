//  Created by Daniyar Mamadov on 16.02.2023.

import Foundation

protocol DataFetcher {
    func getFeed(response: @escaping (FeedResponse?) -> Void)
}

struct NetworkingDataFetcher: DataFetcher {
    
    let defaultNetworkingService: NetworkingService
    
    init(defaultNetworkingService: NetworkingService) {
        self.defaultNetworkingService = defaultNetworkingService
    }
    
    func getFeed(response: @escaping (FeedResponse?) -> Void) {
        let params = ["filters": "post,photo"]
        defaultNetworkingService.request(path: API.newsFeed, params: params) { data, error in
            if let error {
                print("Received error while requesting data: \(error.localizedDescription)")
                response(nil)
            }
            let decoded = decodeJSON(type: FeedResponseWrapped.self, data: data)
            response(decoded?.response)
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, data: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data, let response = try? decoder.decode(T.self, from: data) else { return nil }
        return response
    }
}
