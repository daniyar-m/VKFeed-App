//  Created by Daniyar Mamadov on 03.03.2023.

import UIKit

final class GalleryCollectionView: UICollectionView {
    
    var photos: [FeedCellPhotoAttachmentViewModel] = []
    
    init() {
        let rowLayout = RowLayout()
        super.init(frame: .zero, collectionViewLayout: rowLayout)
        if let rowLayout = collectionViewLayout as? RowLayout {
            rowLayout.delegate = self
        }
        self.delegate = self
        self.dataSource = self
        self.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.identifier)
        
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(with photos: [FeedCellPhotoAttachmentViewModel]) {
        self.photos = photos
        self.contentOffset = .zero
        self.reloadData()
    }
}

extension GalleryCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, RowLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.identifier, for: indexPath) as? GalleryCollectionViewCell else { return UICollectionViewCell() }
        cell.set(imageUrl: photos[indexPath.row].photoUrlString)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, photoAtIndexPath indexPath: IndexPath) -> CGSize {
        return CGSize(width: photos[indexPath.row].width,
                      height: photos[indexPath.row].height)
    }
}
