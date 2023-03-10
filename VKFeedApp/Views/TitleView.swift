//  Created by Daniyar Mamadov on 10.03.2023.

import UIKit

final class TitleView: UIView {
    
    private var mySearchTextField = CustomTextField()
    
    private var avatarImageView: WebImageView = {
        let view = WebImageView()
        view.backgroundColor = .red
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(mySearchTextField)
        addSubview(avatarImageView)
        translatesAutoresizingMaskIntoConstraints = false
        setupConstaints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
    }
    
    private func setupConstaints() {
        NSLayoutConstraint.activate([
            mySearchTextField.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            mySearchTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            mySearchTextField.trailingAnchor.constraint(equalTo: avatarImageView.leadingAnchor, constant: -12),
            mySearchTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            avatarImageView.widthAnchor.constraint(equalTo: mySearchTextField.heightAnchor, multiplier: 1),
            avatarImageView.heightAnchor.constraint(equalTo: mySearchTextField.heightAnchor, multiplier: 1)
        ])
    }
}
