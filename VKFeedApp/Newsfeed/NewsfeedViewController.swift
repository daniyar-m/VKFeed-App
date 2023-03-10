//  Created by Daniyar Mamadov on 16.02.2023.

import UIKit

protocol NewsfeedDisplayLogic: AnyObject {
    func displaySomething(viewModel: Newsfeed.Model.ViewModel.ViewModelData)
}

class NewsfeedViewController: UIViewController, NewsfeedDisplayLogic {
    var interactor: NewsfeedBusinessLogic?
    var router: (NSObjectProtocol & NewsfeedRoutingLogic & NewsfeedDataPassing)?
    
    private var newsfeedViewModel = NewsfeedViewModel(newsfeedCells: [])
    
    private var titleView = TitleView()
    
    private let newsfeedTableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.95, alpha: 1.00)
        return view
    }()
    
// MARK: -  Setup
    
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
    
// MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        setupNavBar()
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
        
    func displaySomething(viewModel: Newsfeed.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayNewsfeed(let feedViewModel):
            print(".displayNewsfeed ViewController")
            self.newsfeedViewModel = feedViewModel
            newsfeedTableView.reloadData()
        }
    }
    
    private func setupNavBar() {
//        self.navigationController?.hidesBarsOnSwipe = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.titleView = titleView
    }
    
    private func configureNewsfeedTableView() {
        newsfeedTableView.delegate = self
        newsfeedTableView.dataSource = self
        newsfeedTableView.register(NewsfeedCell.self, forCellReuseIdentifier: NewsfeedCell.identifier)
        newsfeedTableView.separatorStyle = .none
    }
}

extension NewsfeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsfeedViewModel.newsfeedCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = newsfeedTableView.dequeueReusableCell(withIdentifier: NewsfeedCell.identifier, for: indexPath) as? NewsfeedCell else { return UITableViewCell() }
        cell.fill(with: newsfeedViewModel.newsfeedCells[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return newsfeedViewModel.newsfeedCells[indexPath.row].sizes.totalHeight
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return newsfeedViewModel.newsfeedCells[indexPath.row].sizes.totalHeight
    }
}

extension NewsfeedViewController: NewsfeedCellDelegate {
    func revealPost(for cell: NewsfeedCell) {
        guard let indexPath = newsfeedTableView.indexPath(for: cell) else { return }
        let cellViewModel = newsfeedViewModel.newsfeedCells[indexPath.row]
        interactor?.doSomething(request: .revealPostIDs(id: cellViewModel.postId))
    }
}
