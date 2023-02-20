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
}

protocol FeedCellPhotoAttachmentViewModel {
    var photoUrlString: String? { get }
    var width: Int { get }
    var height: Int { get }
}

final class NewsfeedCell: UITableViewCell {
    
    static let identifier = "NewsfeedTableViewCellID"
    
    private let mainStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.alignment = .fill
        view.spacing = 4
        view.sizeToFit()
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.isLayoutMarginsRelativeArrangement = true
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let topStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = .center
        view.spacing = 4
        view.sizeToFit()
        return view
    }()
    
    private let avatarImageView: WebImageView = {
        let view = WebImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        view.sizeToFit()
        view.layer.cornerRadius = view.frame.width / 2
        view.clipsToBounds = true
//        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        view.alignment = .leading
        view.spacing = 2
        view.sizeToFit()
        return view
    }()
    
    private let nameLabel: UILabel = {
        let view = UILabel()
        view.sizeToFit()
        return view
    }()
    
    private let dateLabel: UILabel = {
        let view = UILabel()
        view.sizeToFit()
        return view
    }()
    
    private let textBodyLabel: UILabel = {
        let view = UILabel()
        view.sizeToFit()
        return view
    }()
    
    private let photoImageView: WebImageView = {
        let view = WebImageView()
        view.sizeToFit()
        return view
    }()
    
    private let bottomStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .equalCentering
        view.alignment = .center
        view.sizeToFit()
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
        self.addSubview(mainStackView)
        mainStackView.addArrangedSubview(topStackView)
        mainStackView.addArrangedSubview(textBodyLabel)
        mainStackView.addArrangedSubview(photoImageView)
        mainStackView.addArrangedSubview(bottomStackView)
        topStackView.addArrangedSubview(avatarImageView)
        topStackView.addArrangedSubview(titleStackView)
        titleStackView.addArrangedSubview(nameLabel)
        titleStackView.addArrangedSubview(dateLabel)
        bottomStackView.addArrangedSubview(likesStackView)
        likesStackView.addArrangedSubview(likesImageView)
        likesStackView.addArrangedSubview(likesCountLabel)
        bottomStackView.addArrangedSubview(commentsStackView)
        commentsStackView.addArrangedSubview(commentsImageView)
        commentsStackView.addArrangedSubview(commentsCountLabel)
        bottomStackView.addArrangedSubview(repostsStackView)
        repostsStackView.addArrangedSubview(repostsImageView)
        repostsStackView.addArrangedSubview(repostsCountLabel)
        bottomStackView.addArrangedSubview(viewsStackView)
        viewsStackView.addArrangedSubview(viewsImageView)
        viewsStackView.addArrangedSubview(viewsCountLabel)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: self.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
            mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4),
            mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4)
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
        if let photoAttachment = viewModel.photoAttachment {
            photoImageView.set(imageUrl: photoAttachment.photoUrlString)
            photoImageView.isHidden = false
        } else {
            photoImageView.isHidden = true
        }
    }
}
