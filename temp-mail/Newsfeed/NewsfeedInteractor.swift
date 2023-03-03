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
    private var revealedPostIDs: [Int] = []
    private var feedResponse: FeedResponse?
    
    func doSomething(request: Newsfeed.Model.Request.RequestType) {
        switch request {
        case .getNewsfeed:
            print(".getNewsfeed Interactor")
            fetcher.getFeed { [weak self] feedResponse in
                self?.feedResponse = feedResponse
                self?.presentFeed()
            }
        case .revealPostIDs(let id):
            revealedPostIDs.append(id)
            presentFeed()
        }
    }
    
    private func presentFeed() {
        guard let feedResponse else { return }
        presenter?.presentSomething(response: .presentNewsfeed(feed: feedResponse, revealedPostIDs: revealedPostIDs))
    }
}
