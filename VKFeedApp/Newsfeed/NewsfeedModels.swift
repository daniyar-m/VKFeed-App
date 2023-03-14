//  Created by Daniyar Mamadov on 16.02.2023.

import UIKit

enum Newsfeed {
    enum Request {
        case getNewsfeed
        case getUser
        case revealPostIDs(_ id: Int)
        case getNextBatch
    }
    
    enum Response {
        case presentNewsfeed(feed: FeedResponse, revealedPostIDs: [Int])
        case presentUser(user: UserResponse?)
        case presentFooterLoader
    }
    
    enum ViewModel {
        case displayNewsfeed(_ feedViewModel: NewsfeedViewModel)
        case displayUser(_ userViewModel: UserViewModel)
        case displayFooterLoader
    }
}

struct UserViewModel: TitleViewViewModel {
    var photo100UrlString: String?
}

struct NewsfeedViewModel {
    
    struct NewsfeedCell: NewsfeedCellViewModel {
        var postId: Int
        var avatarUrlString: String
        var name: String
        var date: String
        var text: String?
        var likes: String?
        var comments: String?
        var reposts: String?
        var views: String?
        var photoAttachments: [FeedCellPhotoAttachmentViewModel]
        var sizes: FeedCellSizes
    }
    
    struct FeedCellPhotoAttachment: FeedCellPhotoAttachmentViewModel {
        var photoUrlString: String?
        var width: Int
        var height: Int
    }
    
    let newsfeedCells: [NewsfeedCell]
}
