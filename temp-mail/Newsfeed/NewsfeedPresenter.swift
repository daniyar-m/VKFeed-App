//  Created by Daniyar Mamadov on 16.02.2023.

import UIKit

protocol NewsfeedPresentationLogic {
    func presentSomething(response: Newsfeed.Model.Response.ResponseType)
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
    
    func presentSomething(response: Newsfeed.Model.Response.ResponseType) {
        switch response {
        case .presentNewsfeed(let feedResponse, let revealedPostIDs):
            print(".presentNewsfeed Presenter")
            print(revealedPostIDs)
            let cells = feedResponse.items.map { cellViewModel(from: $0,
                                                               profiles: feedResponse.profiles,
                                                               groups: feedResponse.groups,
                                                               revealedPostIDs: revealedPostIDs) }
            let feedViewModel = NewsfeedViewModel(newsfeedCells: cells)
            viewController?.displaySomething(viewModel: .displayNewsfeed(feedViewModel))
        }
    }
     
    private func cellViewModel(from feedItem: FeedItem,
                               profiles: [Profile],
                               groups: [Group],
                               revealedPostIDs: [Int]) -> NewsfeedViewModel.NewsfeedCell {
        let profile = profile(for: feedItem.sourceId, profiles: profiles, groups: groups)
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormatter.string(from: date)
        let photoAttachment = photoAttachment(feedItem: feedItem)
        let isFullSizedPost = revealedPostIDs.contains(feedItem.postId)
        let sizes = cellLayoutCalculator.sizes(postText: feedItem.text,
                                               photoAttachment: photoAttachment,
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
                                              photoAttachment: photoAttachment,
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
}
   
 
