//  Created by Daniyar Mamadov on 02.03.2023.

import UIKit

struct Constants {
    static let cardViewInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8)
    
    static let topViewHeight: CGFloat = 36
    static let topViewInsets: UIEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8)
    
    static let nameLabelHeight: CGFloat = topViewHeight / 2 - nameLabelInsets.top
    static let nameLabelInsets: UIEdgeInsets = UIEdgeInsets(top: 2, left: 8, bottom: 0, right: 8)

    static let dateLabelHeight: CGFloat = 14
    static let dateLabelInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 2, right: 8)

    static let postLabelInsets: UIEdgeInsets = UIEdgeInsets(top: 8 + Constants.topViewHeight + 8, left: 8, bottom: 8, right: 8)
    static let postLabelFont = UIFont.systemFont(ofSize: 15)
    
    static let bottomSubviewSize: CGSize = CGSize(width: 80, height: 44)
    
    static let bottomViewIconSize: CGSize = CGSize(width: 24, height: 24)
}
