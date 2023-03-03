//  Created by Daniyar Mamadov on 04.03.2023.

import UIKit

protocol RowLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, photoAtIndexPath indexPath: IndexPath) -> CGSize
}

final class RowLayout: UICollectionViewLayout {
    weak var delegate: RowLayoutDelegate?
    
}
