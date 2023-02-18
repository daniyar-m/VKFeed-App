//  Created by Daniyar Mamadov on 16.02.2023.

import UIKit

protocol NewsfeedPresentationLogic {
    func presentSomething(response: Newsfeed.Model.Response.ResponseType)
}

class NewsfeedPresenter: NewsfeedPresentationLogic {
    weak var viewController: NewsfeedDisplayLogic?
    let dateFormatter: DateFormatter = {
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "ru_RU")
        dt.dateFormat = "d MMM 'в' HH:mm"
        return dt
    }()
    
    func presentSomething(response: Newsfeed.Model.Response.ResponseType) {
        switch response {
        case .presentNewsfeed(let feedResponse):
            print(".presentNewsfeed Presenter")
            let cells = feedResponse.items.map { cellViewModel(from: $0,
                                                               profiles: feedResponse.profiles,
                                                               groups: feedResponse.groups) }
            let feedViewModel = NewsfeedViewModel(newsfeedCells: cells)
            viewController?.displaySomething(viewModel: .displayNewsfeed(feedViewModel))
        }
    }
     
    private func cellViewModel(from feedItem: FeedItem, profiles: [Profile], groups: [Group]) -> NewsfeedViewModel.NewsfeedCell {
        let profile = profile(for: feedItem.sourceId, profiles: profiles, groups: groups)
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormatter.string(from: date)
        return NewsfeedViewModel.NewsfeedCell(avatarUrlString: profile?.photo ?? "",
                                              name: profile?.name ?? "",
                                              date: dateTitle,
                                              text: feedItem.text,
                                              likes: String(feedItem.likes?.count ?? 0),
                                              comments: String(feedItem.comments?.count ?? 0),
                                              reposts: String(feedItem.reposts?.count ?? 0),
                                              views: String(feedItem.views?.count ?? 0))
    }
    
    private func profile(for sourceId: Int, profiles: [Profile], groups: [Group]) -> ProfileRepresentable? {
        let profilesOrGroups: [ProfileRepresentable] = sourceId >= 0 ? profiles : groups
        let normalSourceId = sourceId >= 0 ? sourceId : -sourceId
        let profileRepresentable = profilesOrGroups.first { profileRepresentable in
            profileRepresentable.id == normalSourceId
        }
        return profileRepresentable
    }
}
