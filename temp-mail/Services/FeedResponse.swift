//  Created by Daniyar Mamadov on 16.02.2023.

import Foundation

struct FeedResponseWrapped: Decodable {
    let response: FeedResponse
}

struct FeedResponse: Decodable {
    let items: [FeedItem]
    let profiles: [Profile]
    let groups: [Group]
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
//    let width: Int
//    let height: Int
}

struct PhotoSize: Decodable {
    let type: String
    let url: String
    let width: Int
    let height: Int
}
