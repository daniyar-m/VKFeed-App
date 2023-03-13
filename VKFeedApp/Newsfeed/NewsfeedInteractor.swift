//  Created by Daniyar Mamadov on 16.02.2023.

import UIKit

protocol NewsfeedBusinessLogic {
    func makeRequest(_ request: Newsfeed.Model.Request.RequestType)
}

protocol NewsfeedDataStore {
        //var name: String { get set }
}

class NewsfeedInteractor: NewsfeedBusinessLogic, NewsfeedDataStore {
    var presenter: NewsfeedPresentationLogic?
    var worker: NewsfeedWorker?
    private var fetcher: DataFetcher = DefaultDataFetcher(DefaultNetworkingService())
    private var revealedPostIDs: [Int] = []
    private var feedResponse: FeedResponse?
    private var userResponse: UserResponse?
    
    func makeRequest(_ request: Newsfeed.Model.Request.RequestType) {
        switch request {
        case .getNewsfeed:
            print(".getNewsfeed Interactor")
            fetcher.getFeed { [weak self] feedResponse in
                self?.feedResponse = feedResponse
                self?.presentFeed()
            }
        case .getUser:
            print(".getUser Interactor")
            fetcher.getUser { [weak self] userResponse in
                self?.userResponse = userResponse 
                self?.presenter?.presentData(.presentUserInfo(user: userResponse))
            }
        case .revealPostIDs(let id):
            revealedPostIDs.append(id)
            presentFeed()
        }
    }
    
    private func presentFeed() {
        guard let feedResponse else { return }
        presenter?.presentData(.presentNewsfeed(feed: feedResponse, revealedPostIDs: revealedPostIDs))
    }
}
