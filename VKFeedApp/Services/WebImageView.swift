//  Created by Daniyar Mamadov on 18.02.2023.

import UIKit

class WebImageView: UIImageView {
    
    func set(imageUrl: String?) {
        
        guard let imageUrl, let url = URL(string: imageUrl) else { self.image = nil; return }
        
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            self.image = UIImage(data: cachedResponse.data)
//            print("from cache")
            return
        }
        
//        print("from internet")
        
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let data, let response {
                    self?.image = UIImage(data: data)
                    self?.handleLoadedImage(data: data, response: response)
                }
            }
        }
        
        dataTask.resume()
    }
    
    private func handleLoadedImage(data: Data, response: URLResponse) {
        guard let responseUrl = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseUrl))
    }
}
