//  Created by Daniyar Mamadov on 09.02.2023.

import UIKit

protocol NewsfeedCellViewModel {
    var avatarUrlString: String { get }
    var name: String { get }
    var date: String { get }
    var text: String? { get }
    var likes: String? { get }
    var comments: String? { get }
    var reposts: String? { get }
    var views: String? { get }
    var photoAttachment: FeedCellPhotoAttachmentViewModel? { get }
    var sizes: FeedCellSizes { get }
}

protocol FeedCellPhotoAttachmentViewModel {
    var photoUrlString: String? { get }
    var width: Int { get }
    var height: Int { get }
}

protocol FeedCellSizes {
    var postLabelFrame: CGRect { get }
    var attachmentFrame: CGRect { get }
    var bottomViewFrame: CGRect { get }
    var totalHeight: CGFloat { get }
}

final class NewsfeedCell: UITableViewCell {
    
    static let identifier = "NewsfeedTableViewCellID"
    
    private let cardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.sizeToFit()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let bottomView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .clear
        view.axis = .horizontal
        view.distribution = .equalCentering
        view.alignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let avatarImageView: WebImageView = {
        let view = WebImageView()
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameLabel: UILabel = {
        let view = UILabel()
        view.sizeToFit()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dateLabel: UILabel = {
        let view = UILabel()
        view.sizeToFit()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let textBodyLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.sizeToFit()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let photoImageView: WebImageView = {
        let view = WebImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let likesStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.alignment = .center
        view.spacing = 4
        view.sizeToFit()
        return view
    }()
    
    private let likesImageView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        view.image = UIImage(systemName: "heart")
        view.sizeToFit()
        return view
    }()
    
    private let likesCountLabel: UILabel = {
        let view = UILabel()
        view.sizeToFit()
        return view
    }()
    
    private let commentsStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.alignment = .center
        view.spacing = 4
        view.sizeToFit()
        return view
    }()
    
    private let commentsImageView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        view.image = UIImage(systemName: "text.bubble")
        view.sizeToFit()
        return view
    }()
    
    private let commentsCountLabel: UILabel = {
        let view = UILabel()
        view.sizeToFit()
        return view
    }()
    
    private let repostsStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.alignment = .center
        view.spacing = 4
        view.sizeToFit()
        return view
    }()
    
    private let repostsImageView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        view.image = UIImage(systemName: "arrowshape.turn.up.forward")
        view.sizeToFit()
        return view
    }()
    
    private let repostsCountLabel: UILabel = {
        let view = UILabel()
        view.sizeToFit()
        return view
    }()
    
    private let viewsStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.alignment = .center
        view.spacing = 4
        view.sizeToFit()
        return view
    }()
    
    private let viewsImageView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        view.image = UIImage(systemName: "eye.fill")
        view.sizeToFit()
        return view
    }()
    
    private let viewsCountLabel: UILabel = {
        let view = UILabel()
        view.sizeToFit()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        
        self.addSubview(cardView)
        
        cardView.addSubview(topView)
        cardView.addSubview(textBodyLabel)
        cardView.addSubview(photoImageView)
        cardView.addSubview(bottomView)
        
        topView.addSubview(avatarImageView)
        topView.addSubview(nameLabel)
        topView.addSubview(dateLabel)
        
        bottomView.addArrangedSubview(likesStackView)
        bottomView.addArrangedSubview(commentsStackView)
        bottomView.addArrangedSubview(repostsStackView)
        bottomView.addArrangedSubview(viewsStackView)
        
        likesStackView.addArrangedSubview(likesImageView)
        likesStackView.addArrangedSubview(likesCountLabel)
        
        commentsStackView.addArrangedSubview(commentsImageView)
        commentsStackView.addArrangedSubview(commentsCountLabel)
        
        repostsStackView.addArrangedSubview(repostsImageView)
        repostsStackView.addArrangedSubview(repostsCountLabel)
        
        viewsStackView.addArrangedSubview(viewsImageView)
        viewsStackView.addArrangedSubview(viewsCountLabel)
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            cardView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            cardView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            cardView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            topView.topAnchor.constraint(equalTo: cardView.topAnchor),
            topView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 44),
            
            avatarImageView.topAnchor.constraint(equalTo: topView.topAnchor, constant: 4),
            avatarImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 4),
            avatarImageView.widthAnchor.constraint(equalToConstant: 40),
            avatarImageView.heightAnchor.constraint(equalToConstant: 40),
            
            nameLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 4),
            nameLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -4),
            
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            dateLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 4),
            dateLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -4),
            
            textBodyLabel.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 4),
            textBodyLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 4),
            textBodyLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -4),
            
            photoImageView.topAnchor.constraint(equalTo: textBodyLabel.bottomAnchor, constant: 4),
            photoImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            
            bottomView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 8),
            bottomView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -8),
            bottomView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8),
            bottomView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: NewsfeedCellViewModel) {
        avatarImageView.set(imageUrl: viewModel.avatarUrlString)
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        textBodyLabel.text = viewModel.text
        likesCountLabel.text = viewModel.likes
        commentsCountLabel.text = viewModel.comments
        repostsCountLabel.text = viewModel.reposts
        viewsCountLabel.text = viewModel.views
        
        textBodyLabel.frame = viewModel.sizes.postLabelFrame
        photoImageView.frame = viewModel.sizes.attachmentFrame
        bottomView.frame = viewModel.sizes.bottomViewFrame
        
        if let photoAttachment = viewModel.photoAttachment {
            photoImageView.set(imageUrl: photoAttachment.photoUrlString)
            photoImageView.isHidden = false
        } else {
            photoImageView.isHidden = true
        }
    }
}
