//  Created by Daniyar Mamadov on 16.02.2023.

import UIKit

final class NewsfeedWorker {
    
    private let authService: AuthService
    private let networkingService: NetworkingService
    private let dataFetcher: DataFetcher
    
    private var feedResponse: FeedResponse?
    private var revealedPostIDs: [Int] = []
    private var newFromInProcess: String?
    
    init() {
        self.authService = SceneDelegate.shared().authService
        self.networkingService = DefaultNetworkingService(authService: authService)
        self.dataFetcher = DefaultDataFetcher(networkingService: networkingService)
    }
    
    func getUser(completion: @escaping (UserResponse?) -> Void) {
        dataFetcher.getUser { userResponse in
            completion(userResponse)
        }
    }
    
    func getFeed(completion: @escaping (FeedResponse, [Int]) -> Void) {
        dataFetcher.getFeed(nextBatchFrom: nil) { [weak self] feedResponse in
            self?.feedResponse = feedResponse
            guard let feedResponse = self?.feedResponse,
                  let revealedPostIDs = self?.revealedPostIDs else { return }
            completion(feedResponse, revealedPostIDs)
        }
    }
    
    func revealPostIDs(for postID: Int, completion: @escaping (FeedResponse, [Int]) -> Void) {
        revealedPostIDs.append(postID)
        guard let feedResponse = self.feedResponse else { return }
        completion(feedResponse, revealedPostIDs)
    }
    
    func getNextBatch(completion: @escaping (FeedResponse, [Int]) -> Void) {
        newFromInProcess = feedResponse?.nextFrom
        dataFetcher.getFeed(nextBatchFrom: newFromInProcess) { [weak self] feed in
            guard let feed, self?.feedResponse?.nextFrom != feed.nextFrom else { return }
            if self?.feedResponse == nil {
                self?.feedResponse = feed
            } else {
                self?.feedResponse?.items.append(contentsOf: feed.items)
                self?.feedResponse?.nextFrom = feed.nextFrom
                
                var profiles = feed.profiles
                if let oldProfiles = self?.feedResponse?.profiles {
                    let oldProfilesFiltered = oldProfiles.filter { oldProfile in
                        !feed.profiles.contains(where: { $0.id == oldProfile.id })
                    }
                    profiles.append(contentsOf: oldProfilesFiltered)
                }
                self?.feedResponse?.profiles = profiles
                
                var groups = feed.groups
                if let oldGroups = self?.feedResponse?.groups {
                    let oldGroupsFiltered = oldGroups.filter { oldGroup in
                        !feed.groups.contains(where: { $0.id == oldGroup.id })
                    }
                    groups.append(contentsOf: oldGroupsFiltered)
                }
                self?.feedResponse?.groups = groups
            }
            guard let feedResponse = self?.feedResponse, let revealedPostIDs = self?.revealedPostIDs else { return }
            completion(feedResponse, revealedPostIDs)
        }
    }
}
