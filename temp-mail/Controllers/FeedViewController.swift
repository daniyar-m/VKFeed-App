//
//  ViewController.swift
//  temp-mail
//
//  Created by Daniyar Mamadov on 09.02.2023.
//

import UIKit

class FeedViewController: UIViewController {
    
    private let defaultNetworkingService = DefaultNetworkingService()
    
    let messages: [Message] = [Message(timestamp: Date.distantPast, sender: "Dan", title: "Hello", body: "Heelo world"),
                               Message(timestamp: Date.distantPast, sender: "Mary", title: "How r u?", body: "test"),
                               Message(timestamp: Date.distantPast, sender: "Tim", title: "u good", body: "test"),
                               Message(timestamp: Date.distantPast, sender: "Dan", title: "testing", body: "test"),
                               Message(timestamp: Date.distantPast, sender: "Mary", title: "another test", body: "test"),
                               Message(timestamp: Date.distantPast, sender: "Tim", title: "QWERTY", body: "test"),
                               Message(timestamp: Date.distantPast, sender: "Dan", title: "1234565678987654323456", body: "test"),
                               Message(timestamp: Date.distantPast, sender: "Mary", title: "Long title: qwertyui opasdfg hjkl zx cvbnm,", body: "test"),
                               Message(timestamp: Date.distantPast, sender: "Tim", title: "long body", body: "A timestamp is that which is not readable form when you get it from the server or from other sources. So while to show some event, date or time in your application you have to make a timestamp into the readable form, you can make it readable form using these objects Date, Calendar, DateFormatter and use many more."),
                               Message(timestamp: Date.distantPast, sender: "Dan", title: "BYE!", body: "test")]
    
    private let messagesTableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .orange
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
//        request
        view.backgroundColor = .red
        view.addSubview(messagesTableView)
        NSLayoutConstraint.activate([
            messagesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            messagesTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            messagesTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            messagesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        configureMessagesTableView()
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
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = messagesTableView.dequeueReusableCell(withIdentifier: MessageCell.identifier, for: indexPath) as? MessageCell else { return UITableViewCell() }
        cell.configureCell(message: messages[indexPath.row])
        return cell
    }
    
}
