//
//  MessageCell.swift
//  temp-mail
//
//  Created by Daniyar Mamadov on 09.02.2023.
//

import UIKit

final class MessageCell: UITableViewCell {
    
    static let identifier = "MessageTableViewCellID"
    
    private let verticalStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dateAndTimeLabel: UILabel = {
        let view = UILabel()
        view.sizeToFit()
        return view
    }()
    
    private let senderLabel: UILabel = {
        let view = UILabel()
        view.sizeToFit()
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.sizeToFit()
        return view
    }()
    
    private let bodyLabel: UILabel = {
        let view = UILabel()
        view.sizeToFit()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .yellow
        self.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(dateAndTimeLabel)
        verticalStackView.addArrangedSubview(senderLabel)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(bodyLabel)
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: self.topAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(message: Message) {
        dateAndTimeLabel.text = "\(message.timestamp)"
        senderLabel.text = "\(message.sender)"
        titleLabel.text = "\(message.title)"
        bodyLabel.text = "\(message.body)"
    }
}
