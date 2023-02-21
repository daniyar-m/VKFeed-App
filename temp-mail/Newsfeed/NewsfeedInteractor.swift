//  Created by Daniyar Mamadov on 16.02.2023.

import UIKit

protocol NewsfeedBusinessLogic {
    func doSomething(request: Newsfeed.Model.Request.RequestType)
}

protocol NewsfeedDataStore {
        //var name: String { get set }
}

class NewsfeedInteractor: NewsfeedBusinessLogic, NewsfeedDataStore {
    var presenter: NewsfeedPresentationLogic?
    var worker: NewsfeedWorker?
    private var fetcher: DataFetcher = NetworkDataFetcher(DefaultNetworkingService())
        
    func doSomething(request: Newsfeed.Model.Request.RequestType) {
        switch request {
        case .getNewsfeed:
            print(".getNewsfeed Interactor")
            fetcher.getFeed { [weak self] feedResponse in
                guard let feedResponse else { return }
                self?.presenter?.presentSomething(response: .presentNewsfeed(feedResponse))
            }
        }
    }
}
