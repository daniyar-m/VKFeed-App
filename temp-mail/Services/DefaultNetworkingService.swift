//  Created by Daniyar Mamadov on 13.02.2023.

import Foundation

final class DefaultNetworkingService: NetworkingService {
    
    private let authService: AuthService
    
    init(authService:AuthService = SceneDelegate.shared().authService) {
        self.authService = authService
    }
    
    func request(path: String, params: Dictionary<String, String>, completion: @escaping (Data?, Error?) -> Void) {
        guard let token = authService.token else { return }
        var allParams = params
        allParams["access_token"] = token
        allParams["v"] = API.version
        guard let url = generateURL(from: path, params: allParams) else { return }
        print(url)
        
        let session = URLSession(configuration: .default)
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
        task.resume()
    }
    
    private func generateURL(from path: String, params: [String: String]) -> URL? {
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = API.newsFeed
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        return components.url
    }
}
