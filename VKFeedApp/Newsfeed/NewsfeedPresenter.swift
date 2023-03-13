//  Created by Daniyar Mamadov on 16.02.2023.

import UIKit

protocol NewsfeedPresentationLogic {
    func presentData(_ data: Newsfeed.Model.Response.ResponseType)
}

class NewsfeedPresenter: NewsfeedPresentationLogic {
    
    weak var viewController: NewsfeedDisplayLogic?
    
    var cellLayoutCalculator: FeedCellLayoutCalculator = NewsfeedCellLayoutCalculator()
    
    let dateFormatter: DateFormatter = {
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "ru_RU")
        dt.dateFormat = "d MMM 'в' HH:mm"
        return dt
    }()
    
    func presentData(_ data: Newsfeed.Model.Response.ResponseType) {
        switch data {
        case .presentNewsfeed(let feed, let revealedPostIDs):
            print(".presentNewsfeed Presenter")
            let cells = feed.items.map { cellViewModel(from: $0,
                                                               profiles: feed.profiles,
                                                               groups: feed.groups,
                                                               revealedPostIDs: revealedPostIDs) }
            let feedViewModel = NewsfeedViewModel(newsfeedCells: cells)
            viewController?.displayData(.displayNewsfeed(feedViewModel))
        case .presentUserInfo(let user):
            print(".presentUserInfo Presenter")
            let userViewModel = UserViewModel(photo100UrlString: user?.photo100)
            viewController?.displayData(.displayUser(userViewModel))
        }
    }
     
    private func cellViewModel(from feedItem: FeedItem,
                               profiles: [Profile],
                               groups: [Group],
                               revealedPostIDs: [Int]) -> NewsfeedViewModel.NewsfeedCell {
        let profile = profile(for: feedItem.sourceId, profiles: profiles, groups: groups)
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormatter.string(from: date)
        let photoAttachments = photoAttachments(feedItem: feedItem)
        let isFullSizedPost = revealedPostIDs.contains(feedItem.postId)
        let sizes = cellLayoutCalculator.sizes(postText: feedItem.text,
                                               photoAttachments: photoAttachments,
                                               isFullSizedPost: isFullSizedPost)
        return NewsfeedViewModel.NewsfeedCell(postId: feedItem.postId,
                                              avatarUrlString: profile?.photo ?? "",
                                              name: profile?.name ?? "",
                                              date: dateTitle,
                                              text: feedItem.text,
                                              likes: String(feedItem.likes?.count ?? 0),
                                              comments: String(feedItem.comments?.count ?? 0),
                                              reposts: String(feedItem.reposts?.count ?? 0),
                                              views: String(feedItem.views?.count ?? 0),
                                              photoAttachments: photoAttachments,
                                              sizes: sizes)
    }
    
    private func profile(for sourceId: Int, profiles: [Profile], groups: [Group]) -> ProfileRepresentable? {
        let profilesOrGroups: [ProfileRepresentable] = sourceId >= 0 ? profiles : groups
        let normalSourceId = sourceId >= 0 ? sourceId : -sourceId
        let profileRepresentable = profilesOrGroups.first { profileRepresentable in
            profileRepresentable.id == normalSourceId
        }
        return profileRepresentable
    }
    
    private func photoAttachment(feedItem: FeedItem) -> NewsfeedViewModel.FeedCellPhotoAttachment? {
        guard let photos = feedItem.attachments?.compactMap({ attachment in attachment.photo}),
              let firstPhoto = photos.first else { return nil }
        return NewsfeedViewModel.FeedCellPhotoAttachment(photoUrlString: firstPhoto.srcBIG,
                                                         width: firstPhoto.width,
                                                         height: firstPhoto.height)
    }
    
    private func photoAttachments(feedItem: FeedItem) -> [NewsfeedViewModel.FeedCellPhotoAttachment] {
        guard let attachments = feedItem.attachments else { return [] }
        return attachments.compactMap { attachment -> NewsfeedViewModel.FeedCellPhotoAttachment? in
            guard let photo = attachment.photo else { return nil }
            return NewsfeedViewModel.FeedCellPhotoAttachment(photoUrlString: photo.srcBIG,
                                                             width: photo.width,
                                                             height: photo.height)
        }
    }
}
