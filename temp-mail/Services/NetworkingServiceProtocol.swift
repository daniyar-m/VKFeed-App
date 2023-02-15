//  Created by Daniyar Mamadov on 10.02.2023.

import Foundation

protocol NetworkingService {
    func request(path: String, params: Dictionary<String, String>, completion: @escaping (Data?, Error?) -> Void)
}
