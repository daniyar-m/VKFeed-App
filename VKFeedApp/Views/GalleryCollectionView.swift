//  Created by Daniyar Mamadov on 03.03.2023.

import UIKit

final class GalleryCollectionView: UICollectionView {
    
    var photos: [FeedCellPhotoAttachmentViewModel] = []
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        self.delegate = self
        self.dataSource = self
        self.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.identifier)
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(with photos: [FeedCellPhotoAttachmentViewModel]) {
        self.photos = photos
        self.reloadData()
    }
}

extension GalleryCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.identifier, for: indexPath) as? GalleryCollectionViewCell else { return UICollectionViewCell() }
        cell.set(imageUrl: photos[indexPath.row].photoUrlString)
        return cell
    }
}
