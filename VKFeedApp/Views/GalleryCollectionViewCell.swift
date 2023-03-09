//  Created by Daniyar Mamadov on 03.03.2023.

import UIKit

final class GalleryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "GalleryCollectionViewCellID"
    
    private let photoImageView: WebImageView = {
        let view = WebImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(photoImageView)
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
    
    override func layoutSubviews() {
        photoImageView.layer.cornerRadius = 8
        photoImageView.clipsToBounds = true
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize(width: 2.5, height: 4)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        photoImageView.set(imageUrl: nil)
    }
    
    func set(imageUrl: String?) {
        photoImageView.set(imageUrl: imageUrl)
    }
}
