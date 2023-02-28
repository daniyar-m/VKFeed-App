//  Created by Daniyar Mamadov on 16.02.2023.

import UIKit

enum Newsfeed {
        // MARK: Use cases
    
    enum Model {
        
        struct Request {
            enum RequestType {
                case getNewsfeed
            }
        }
        
        struct Response {
            enum ResponseType {
                case presentNewsfeed(_ feed: FeedResponse)
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
        var avatarUrlString: String
        var name: String
        var date: String
        var text: String?
        var likes: String?
        var comments: String?
        var reposts: String?
        var views: String?
        var photoAttachment: FeedCellPhotoAttachmentViewModel?
        var sizes: FeedCellSizes
    }
    struct FeedCellPhotoAttachment: FeedCellPhotoAttachmentViewModel {
        var photoUrlString: String?
        var width: Int
        var height: Int
    }
    let newsfeedCells: [NewsfeedCell]
}
