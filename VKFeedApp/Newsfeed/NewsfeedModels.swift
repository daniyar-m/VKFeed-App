//  Created by Daniyar Mamadov on 16.02.2023.

import UIKit

enum Newsfeed {
        // MARK: Use cases
    
    enum Model {
        
        struct Request {
            enum RequestType {
                case getNewsfeed
                case revealPostIDs(id: Int)
            }
        }
        
        struct Response {
            enum ResponseType {
                case presentNewsfeed(feed: FeedResponse, revealedPostIDs: [Int])
            }
        }
        
        struct ViewModel {
            enum ViewModelData {
                case displayNewsfeed(_ feedViewModel: NewsfeedViewModel)
            }
        }
    }
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
