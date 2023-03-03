//  Created by Daniyar Mamadov on 21.02.2023.

import UIKit

struct Sizes: FeedCellSizes {
    var postLabelFrame: CGRect
    var moreTextButtonFrame: CGRect
    var attachmentFrame: CGRect
    var bottomViewFrame: CGRect
    var totalHeight: CGFloat
}

protocol FeedCellLayoutCalculator {
    func sizes(postText: String?,
               photoAttachments: [FeedCellPhotoAttachmentViewModel],
               isFullSizedPost: Bool) -> FeedCellSizes
}

final class NewsfeedCellLayoutCalculator: FeedCellLayoutCalculator {
    
    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }
    
    func sizes(postText: String?,
               photoAttachments: [FeedCellPhotoAttachmentViewModel],
               isFullSizedPost: Bool) -> FeedCellSizes {
        
        var isMoreTextButtonDisplayed = false
        
        let cardViewWidth = screenWidth - Constants.cardViewInsets.left - Constants.cardViewInsets.right
        
        // MARK: - Работа с postLabelFrame
        var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInsets.left,
                                                    y: Constants.postLabelInsets.top),
                                    size: .zero)
        if let postText, !postText.isEmpty {
            let width = cardViewWidth - Constants.postLabelInsets.left - Constants.postLabelInsets.right
            var height = postText.height(width: width, font: Constants.postLabelFont)
            
            let heightLimit = Constants.postLabelFont.lineHeight * Constants.minifiedPostLinesLimit
            if !isFullSizedPost && height > heightLimit {
                height = Constants.postLabelFont.lineHeight * Constants.minifiedPostLines
                isMoreTextButtonDisplayed = true
            }
            
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        // MARK: - Работа с moreTextButton
        let moreTextButtonSize = isMoreTextButtonDisplayed ? Constants.moreTextButtonSize : CGSize.zero
        let moreTextButtonFrame = CGRect(origin: CGPoint(x: Constants.moretextButtonInsets.left,
                                                         y: postLabelFrame.maxY),
                                         size: moreTextButtonSize)
        
        // MARK: - Работа с attachmentFrame
        let attachmentPosY = postLabelFrame.size == CGSize.zero ? Constants.postLabelInsets.top
                                                                : moreTextButtonFrame.maxY + Constants.postLabelInsets.bottom
        var attachmentFrame = CGRect(origin: CGPoint(x: 0, y: attachmentPosY), size: .zero)
                
        if let attachment = photoAttachments.first {
            let aspectRatio = Float(attachment.height) / Float(attachment.width)
            if photoAttachments.count == 1 {
                attachmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * CGFloat(aspectRatio))
            } else if photoAttachments.count > 1 {
                print("More then 1 photo")
                attachmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * CGFloat(aspectRatio))
            }
        }
        
        // MARK: - Работа с bottomViewFrame
        let bottomViewPosY = max(postLabelFrame.maxY, attachmentFrame.maxY)
        let bottomViewFrame = CGRect(origin: CGPoint(x: 0, y: bottomViewPosY),
                                     size: CGSize(width: cardViewWidth, height: Constants.bottomSubviewSize.height))
        
        // MARK: - Работа с bottomViewFrame
        let totalHeight = bottomViewFrame.maxY + Constants.cardViewInsets.bottom
        
        return Sizes(postLabelFrame: postLabelFrame,
                     moreTextButtonFrame: moreTextButtonFrame,
                     attachmentFrame: attachmentFrame,
                     bottomViewFrame: bottomViewFrame,
                     totalHeight: totalHeight)
    }
}
