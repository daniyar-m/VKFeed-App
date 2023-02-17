//  Created by Daniyar Mamadov on 16.02.2023.

import UIKit

protocol NewsfeedDisplayLogic: AnyObject {
    func displaySomething(viewModel: Newsfeed.Model.ViewModel.ViewModelData)
}

class NewsfeedViewController: UIViewController, NewsfeedDisplayLogic {
    var interactor: NewsfeedBusinessLogic?
    var router: (NSObjectProtocol & NewsfeedRoutingLogic & NewsfeedDataPassing)?
    
    private var newsfeedViewModel = NewsfeedViewModel(newsfeedCells: [])
    
// MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = NewsfeedInteractor()
        let presenter = NewsfeedPresenter()
        let router = NewsfeedRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
// MARK: View lifecycle
    
    private let newsfeedTableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .orange
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        setup()
        view.addSubview(newsfeedTableView)
        NSLayoutConstraint.activate([
            newsfeedTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newsfeedTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            newsfeedTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            newsfeedTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        configureNewsfeedTableView()
        interactor?.doSomething(request: .getNewsfeed)
    }
    
    private func configureNewsfeedTableView() {
        newsfeedTableView.delegate = self
        newsfeedTableView.dataSource = self
        newsfeedTableView.register(NewsfeedCell.self, forCellReuseIdentifier: NewsfeedCell.identifier)
        newsfeedTableView.estimatedRowHeight = 60
        newsfeedTableView.rowHeight = UITableView.automaticDimension
        newsfeedTableView.separatorStyle = .singleLine
    }
        
    func displaySomething(viewModel: Newsfeed.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayNewsfeed(let feedViewModel):
            print(".displayNewsfeed ViewController")
            self.newsfeedViewModel = feedViewModel
            newsfeedTableView.reloadData()
        }
    }
}

extension NewsfeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsfeedViewModel.newsfeedCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = newsfeedTableView.dequeueReusableCell(withIdentifier: NewsfeedCell.identifier, for: indexPath) as? NewsfeedCell else { return UITableViewCell() }
        cell.configure(with: newsfeedViewModel.newsfeedCells[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
}