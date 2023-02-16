//
//  ViewController.swift
//  temp-mail
//
//  Created by Daniyar Mamadov on 09.02.2023.
//

import UIKit

class FeedViewController: UIViewController {
    
    private let networkingDataFetcher: DataFetcher = NetworkingDataFetcher(defaultNetworkingService: DefaultNetworkingService())
    
    private let messagesTableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .orange
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        view.addSubview(messagesTableView)
        NSLayoutConstraint.activate([
            messagesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            messagesTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            messagesTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            messagesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        configureMessagesTableView()
        
        networkingDataFetcher.getFeed { feedResponse in
            guard let feedResponse else { return }
            feedResponse.items.map { print($0.date) }
        }
    }

    private func configureMessagesTableView() {
        messagesTableView.delegate = self
        messagesTableView.dataSource = self
        messagesTableView.register(MessageCell.self, forCellReuseIdentifier: MessageCell.identifier)
        messagesTableView.estimatedRowHeight = 60
        messagesTableView.rowHeight = UITableView.automaticDimension
        messagesTableView.separatorStyle = .singleLine
    }

}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = messagesTableView.dequeueReusableCell(withIdentifier: MessageCell.identifier, for: indexPath) as? MessageCell else { return UITableViewCell() }
        cell.configureCell(message: Message(timestamp: Date.now, sender: "danikm@yandex.ru", title: "Hello", body: "mazafaka"))
        return cell
    }
    
}
