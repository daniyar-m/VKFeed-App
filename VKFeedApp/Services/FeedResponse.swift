//  Created by Daniyar Mamadov on 16.02.2023.

import Foundation

struct FeedResponseWrapped: Decodable {
    let response: FeedResponse
}

struct FeedResponse: Decodable {
    var items: [FeedItem]
    var profiles: [Profile]
    var groups: [Group]
    var nextFrom: String?
}

struct FeedItem: Decodable {
    let sourceId: Int
    let postId: Int
    let text: String?
    let date: Double
    let comments: CountableItem?
    let likes: CountableItem?
    let reposts: CountableItem?
    let views: CountableItem?
    let attachments: [Attachment]?
}

struct CountableItem: Decodable {
    let count: Int
}

protocol ProfileRepresentable {
    var id: Int { get }
    var name: String { get }
    var photo: String{ get }
}

struct Profile: Decodable, ProfileRepresentable {
    let id: Int
    let firstName: String
    let lastName: String
    let photo100: String
    var name: String { return firstName + " " + lastName}
    var photo: String {return photo100}
}

struct Group: Decodable, ProfileRepresentable {
    let id: Int
    let name: String
    let photo100: String
    var photo: String { return photo100 }
}

struct Attachment: Decodable {
//    let type: String
    let photo: Photo?
}

struct Photo: Decodable {
        //    let id: Int
    let sizes: [PhotoSize]
        //    let albumId: Int
        //    let ownerId: Int
        //    let userId: Int
        //    let text: String
        //    let date: Int
    
    var width: Int {
        return getProperSize().width
    }
    
    var height: Int {
        return getProperSize().height
    }
    
    var srcBIG: String {
        return getProperSize().url
    }
    
    private func getProperSize() -> PhotoSize {
        if let sizeX = sizes.first(where: { $0.type == "x" }) {
            return sizeX
        } else if let fallBackSize = sizes.last {
            return fallBackSize
        } else {
            return PhotoSize(type: "wrong image", url: "wrong image", width: 0, height: 0)
        }
    }
}

struct PhotoSize: Decodable {
    let type: String
    let url: String
    let width: Int
    let height: Int
}
