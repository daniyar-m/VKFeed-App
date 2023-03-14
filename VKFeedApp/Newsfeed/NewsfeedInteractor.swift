//  Created by Daniyar Mamadov on 16.02.2023.

import UIKit

protocol NewsfeedBusinessLogic {
    func makeRequest(_ request: Newsfeed.Request)
}

final class NewsfeedInteractor: NewsfeedBusinessLogic {
    var presenter: NewsfeedPresentationLogic?
    var worker: NewsfeedWorker?
    
    func makeRequest(_ request: Newsfeed.Request) {
        if worker == nil {
            worker = NewsfeedWorker()
        }
        
        switch request {
        case .getNewsfeed:
            worker?.getFeed(completion: { [weak self] feed, revealedPostIDs in
                self?.presenter?.presentData(.presentNewsfeed(feed: feed, revealedPostIDs: revealedPostIDs))
            })
        case .getUser:
            worker?.getUser(completion: { [weak self] user in
                self?.presenter?.presentData(.presentUser(user: user))
            })
        case .revealPostIDs(let postID):
            worker?.revealPostIDs(for: postID, completion: { [weak self] feed, revealedPostIDs in
                self?.presenter?.presentData(.presentNewsfeed(feed: feed, revealedPostIDs: revealedPostIDs))
            })
        case .getNextBatch:
            self.presenter?.presentData(.presentFooterLoader)
            worker?.getNextBatch(completion: { feed, revealedPostIDs in
                self.presenter?.presentData(.presentNewsfeed(feed: feed, revealedPostIDs: revealedPostIDs))
            })
        }
    }
}
