//  Created by Daniyar Mamadov on 16.02.2023.

import Foundation

protocol DataFetcher {
    func getFeed(nextBatchFrom: String?, response: @escaping (FeedResponse?) -> Void)
    func getUser(response: @escaping (UserResponse?) -> Void)
}

struct DefaultDataFetcher: DataFetcher {
    
    private let authService: AuthService
    private let defaultNetworkingService: NetworkingService
    
    init(authService: AuthService = SceneDelegate.shared().authService, networkingService: NetworkingService) {
        self.authService = authService
        self.defaultNetworkingService = networkingService
    }
    
    func getFeed(nextBatchFrom: String?, response: @escaping (FeedResponse?) -> Void) {
        var params = ["filters": "post,photo"]
        params["start_from"] = nextBatchFrom
        defaultNetworkingService.request(path: API.newsFeed, params: params) { data, error in
            if let error {
                print("Received error while requesting data: \(error.localizedDescription)")
                response(nil)
            }
            let decodedData = decodeJSON(type: FeedResponseWrapped.self, data: data)
            response(decodedData?.response)
        }
    }
    
    func getUser(response: @escaping (UserResponse?) -> Void) {
        guard let userId = authService.userId else { return }
        let params = ["user_ids": userId, "fields": "photo_100"]
        defaultNetworkingService.request(path: API.user, params: params) { data, error in
            if let error {
                print("Received error while requesting data: \(error.localizedDescription)")
                response(nil)
            }
            let decodedData = decodeJSON(type: UserResponseWrapped.self, data: data)
            response(decodedData?.response.first)
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, data: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data, let response = try? decoder.decode(T.self, from: data) else { return nil }
        return response
    }
}
