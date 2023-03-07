//  Created by Daniyar Mamadov on 04.03.2023.

import UIKit

protocol RowLayoutDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, photoAtIndexPath indexPath: IndexPath) -> CGSize
}

final class RowLayout: UICollectionViewLayout {
    weak var delegate: RowLayoutDelegate?
    
    fileprivate var numberOfRows = 1
    fileprivate var cellPadding: CGFloat = 8
    
    fileprivate var cache: [UICollectionViewLayoutAttributes] = []
    
    fileprivate var contentWidth: CGFloat = 0
    fileprivate var contentHeight: CGFloat {
        guard let collectionView else { return 0 }
        let insets = collectionView.contentInset
        return collectionView.bounds.height - insets.left - insets.right
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        guard cache.isEmpty, let collectionView, let delegate else { return }
        var photosSizes: [CGSize] = []
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(row: item, section: 0)
            let photoSize = delegate.collectionView(collectionView, photoAtIndexPath: indexPath)
            photosSizes.append(photoSize)
        }
        guard let rowHeight = self.calculateRowHeight(superviewWidth: collectionView.frame.width, photosSizes: photosSizes) else { return }
        
        var photosRatios = photosSizes.map { $0.height / $0.width }
        
        var offsetX: [CGFloat] = .init(repeating: 0, count: numberOfRows)
        var offsetY: [CGFloat] = []
        
        for row in 0 ..< numberOfRows {
            offsetY.append(CGFloat(row) * rowHeight)
        }
        
        var row = 0
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(row: item, section: 0)
            let width = rowHeight / photosRatios[indexPath.row]
            let frame = CGRect(x: offsetX[row], y: offsetY[row], width: width, height: rowHeight)
            
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attribute.frame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            cache.append(attribute)
            
            contentWidth = max(contentWidth, frame.maxX)
            offsetX[row] += width
        }
    }
    
    private func calculateRowHeight(superviewWidth: CGFloat, photosSizes: [CGSize]) -> CGFloat? {
        let photosWithMinRatio = photosSizes.min { (first, second) -> Bool in
            (first.height / first.width) < (second.height / second.width)
        }
        
        guard let myPhotosWithMinRatio = photosWithMinRatio else { return nil }
        let diff = superviewWidth / myPhotosWithMinRatio.width
        
        return myPhotosWithMinRatio.height * diff
    }
}
