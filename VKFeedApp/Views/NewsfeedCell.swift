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
    var photoAttachments: [FeedCellPhotoAttachmentViewModel] { get }
    var sizes: FeedCellSizes { get }
}

protocol FeedCellPhotoAttachmentViewModel {
    var photoUrlString: String? { get }
    var width: Int { get }
    var height: Int { get }
}

protocol FeedCellSizes {
    var postLabelFrame: CGRect { get }
    var moreTextButtonFrame: CGRect { get }
    var attachmentFrame: CGRect { get }
    var bottomViewFrame: CGRect { get }
    var totalHeight: CGFloat { get }
}

protocol NewsfeedCellDelegate: AnyObject {
    func revealPost(for cell: NewsfeedCell)
}

final class NewsfeedCell: UITableViewCell {
    
    static let identifier = "NewsfeedTableViewCellID"
    
    weak var delegate: NewsfeedCellDelegate?
    
    // MARK: - first layer subview
    
    private let cardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    // MARK: - second layer subviews
    
    private let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.sizeToFit()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let postTextView: UITextView = {
        let view = UITextView()
        view.isScrollEnabled = false
        view.isSelectable = true
        view.isUserInteractionEnabled = true
        view.isEditable = false
        view.dataDetectorTypes = .all
        let padding = view.textContainer.lineFragmentPadding
        view.textContainerInset = UIEdgeInsets(top: 0, left: -padding, bottom: 0, right: -padding)
        view.font = Constants.postLabelFont
        view.textColor = .black
        return view
    }()
    
    private lazy var moreTextButton: UIButton = {
        let view = UIButton()
        view.setTitle("Показать полностью...", for: .normal)
        view.setTitleColor(.blue, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        view.contentHorizontalAlignment = .left
        view.contentVerticalAlignment = .center
        view.addTarget(self, action: #selector(moreTextButtonTapped), for: .touchUpInside)
        return view
    }()
    
    private let postImageView: WebImageView = {
        let view = WebImageView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let galleryCollectionView = GalleryCollectionView()
    
    private let bottomView: UIView = {
        let view = UIView()
        return view
    }()
    
    
    // MARK: - third layer subviews - topView
    
    private let avatarImageView: WebImageView = {
        let view = WebImageView()
        view.layer.cornerRadius = Constants.topViewHeight / 2
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        view.textColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dateLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 12)
        view.textColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

    // MARK: - third layer subviews - bottomView
    
    private let likesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let commentsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let repostsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let viewsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    // MARK: - fourth layer subviews - bottomView
    
    private let likesImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "heart")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let commentsImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "text.bubble")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let repostsImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "arrowshape.turn.up.forward")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let viewsImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "eye.fill")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let likesLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        view.textColor = .lightGray
        view.lineBreakMode = .byClipping
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let commentsLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        view.textColor = .lightGray
        view.lineBreakMode = .byClipping
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let repostsLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        view.textColor = .lightGray
        view.lineBreakMode = .byClipping
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let viewsLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        view.textColor = .lightGray
        view.lineBreakMode = .byClipping
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func prepareForReuse() {
        avatarImageView.set(imageUrl: nil)
        postImageView.set(imageUrl: nil)
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.selectionStyle = .none
        
        layoutFirstLayerSubviews()
        layoutSecondLayerSubviews()
        layoutThirdLayerSubviews()
        layoutFourthLayerSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(with viewModel: NewsfeedCellViewModel) {
        avatarImageView.set(imageUrl: viewModel.avatarUrlString)
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postTextView.text = viewModel.text
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        repostsLabel.text = viewModel.reposts
        viewsLabel.text = viewModel.views
        
        postTextView.frame = viewModel.sizes.postLabelFrame
        moreTextButton.frame = viewModel.sizes.moreTextButtonFrame
        bottomView.frame = viewModel.sizes.bottomViewFrame
        
        if let photoAttachment = viewModel.photoAttachments.first, viewModel.photoAttachments.count == 1 {
            postImageView.set(imageUrl: photoAttachment.photoUrlString)
            postImageView.isHidden = false
            galleryCollectionView.isHidden = true
            postImageView.frame = viewModel.sizes.attachmentFrame
        } else if viewModel.photoAttachments.count > 1 {
            postImageView.isHidden = true
            galleryCollectionView.isHidden = false
            galleryCollectionView.frame = viewModel.sizes.attachmentFrame
            galleryCollectionView.fill(with: viewModel.photoAttachments)
        } else {
            postImageView.isHidden = true
            galleryCollectionView.isHidden = true
        }
    }
    
    private func layoutFirstLayerSubviews() {
        self.contentView.addSubview(cardView)
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: self.contentView.topAnchor,
                                          constant: Constants.cardViewInsets.top),
            cardView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,
                                              constant: Constants.cardViewInsets.left),
            cardView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,
                                               constant: -Constants.cardViewInsets.right),
            cardView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,
                                             constant: -Constants.cardViewInsets.bottom)
        ])
    }
    
    private func layoutSecondLayerSubviews() {
        cardView.addSubview(topView)
        cardView.addSubview(postTextView)
        cardView.addSubview(moreTextButton)
        cardView.addSubview(postImageView)
        cardView.addSubview(galleryCollectionView)
        cardView.addSubview(bottomView)
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: Constants.topViewInsets.top),
            topView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: Constants.topViewInsets.left),
            topView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -Constants.topViewInsets.right),
            topView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight)
            
            // postlabel constraints
            // не нужны, так как размеры задаются динамически
            
            // moreTextButton constraints
            // не нужны, так как размеры задаются динамически
            
            // postImageView constraints
            // не нужны, так как размеры задаются динамически
            
            // galleryCollectionView constraints
            // не нужны, так как размеры задаются динамически
            
            // bottomView constraints
            // не нужны, так как размеры задаются динамически
        ])
    }
    
    private func layoutThirdLayerSubviews() {
        topView.addSubview(avatarImageView)
        topView.addSubview(nameLabel)
        topView.addSubview(dateLabel)
        
        bottomView.addSubview(likesView)
        bottomView.addSubview(commentsView)
        bottomView.addSubview(repostsView)
        bottomView.addSubview(viewsView)

        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topView.topAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight),
            avatarImageView.widthAnchor.constraint(equalToConstant: Constants.topViewHeight),

            nameLabel.topAnchor.constraint(equalTo: topView.topAnchor,
                                           constant: Constants.nameLabelInsets.top),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor,
                                               constant: Constants.nameLabelInsets.left),
            nameLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor,
                                                constant: -Constants.nameLabelInsets.right),
            nameLabel.heightAnchor.constraint(equalToConstant: Constants.nameLabelHeight),
            
            
            dateLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor,
                                               constant: Constants.dateLabelInsets.left),
            dateLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor,
                                                constant: -Constants.dateLabelInsets.right),
            dateLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor,
                                           constant: -Constants.dateLabelInsets.bottom),
            dateLabel.heightAnchor.constraint(equalToConstant: Constants.dateLabelHeight),
            
            
            likesView.topAnchor.constraint(equalTo: bottomView.topAnchor),
            likesView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            likesView.widthAnchor.constraint(equalToConstant: Constants.bottomSubviewSize.width),
            likesView.heightAnchor.constraint(equalToConstant: Constants.bottomSubviewSize.height),
            
            commentsView.topAnchor.constraint(equalTo: bottomView.topAnchor),
            commentsView.leadingAnchor.constraint(equalTo: likesView.trailingAnchor),
            commentsView.widthAnchor.constraint(equalToConstant: Constants.bottomSubviewSize.width),
            commentsView.heightAnchor.constraint(equalToConstant: Constants.bottomSubviewSize.height),
            
            repostsView.topAnchor.constraint(equalTo: bottomView.topAnchor),
            repostsView.leadingAnchor.constraint(equalTo: commentsView.trailingAnchor),
            repostsView.widthAnchor.constraint(equalToConstant: Constants.bottomSubviewSize.width),
            repostsView.heightAnchor.constraint(equalToConstant: Constants.bottomSubviewSize.height),
            
            viewsView.topAnchor.constraint(equalTo: bottomView.topAnchor),
            viewsView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            viewsView.widthAnchor.constraint(equalToConstant: Constants.bottomSubviewSize.width),
            viewsView.heightAnchor.constraint(equalToConstant: Constants.bottomSubviewSize.height)
        ])
    }
    
    private func layoutFourthLayerSubviews() {
        likesView.addSubview(likesImageView)
        likesView.addSubview(likesLabel)
        
        commentsView.addSubview(commentsImageView)
        commentsView.addSubview(commentsLabel)
        
        repostsView.addSubview(repostsImageView)
        repostsView.addSubview(repostsLabel)
        
        viewsView.addSubview(viewsImageView)
        viewsView.addSubview(viewsLabel)
        
        setupConstaintsToFourthLayer(view: likesView, imageView: likesImageView, label: likesLabel)
        setupConstaintsToFourthLayer(view: commentsView, imageView: commentsImageView, label: commentsLabel)
        setupConstaintsToFourthLayer(view: repostsView, imageView: repostsImageView, label: repostsLabel)
        setupConstaintsToFourthLayer(view: viewsView, imageView: viewsImageView, label: viewsLabel)
    }
    
    private func setupConstaintsToFourthLayer(view: UIView, imageView: UIImageView, label: UILabel) {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: Constants.bottomViewIconSize.width),
            imageView.heightAnchor.constraint(equalToConstant: Constants.bottomViewIconSize.height),

            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 4),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc private func moreTextButtonTapped() {
        delegate?.revealPost(for: self)
    }
}
