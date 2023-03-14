//  Created by Daniyar Mamadov on 16.02.2023.

import UIKit

protocol NewsfeedDisplayLogic: AnyObject {
    func displayData(_ viewModel: Newsfeed.ViewModel)
}

final class NewsfeedViewController: UIViewController, NewsfeedDisplayLogic {
    var interactor: NewsfeedBusinessLogic?
    
    private var newsfeedViewModel = NewsfeedViewModel(newsfeedCells: [])
    
    private let titleView = TitleView()
    private lazy var footerView = FooterView()
    
    private lazy var refreshControl: UIRefreshControl = {
        let view = UIRefreshControl()
        view.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return view
    }()
    
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
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
    }
    
// MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setup()
        setupNavBar()
        setupNewsfeedTableView()
        
        interactor?.makeRequest(.getNewsfeed)
        interactor?.makeRequest(.getUser)
    }
        
    func displayData(_ viewModel: Newsfeed.ViewModel) {
        switch viewModel {
        case .displayNewsfeed(let feedViewModel):
            print(".displayNewsfeed ViewController")
            self.newsfeedViewModel = feedViewModel
            newsfeedTableView.reloadData()
            refreshControl.endRefreshing()
            footerView.setTitle(String(feedViewModel.newsfeedCells.count) + " постов")
        case .displayUser(let userViewModel):
            print(".displayUser ViewController")
            titleView.fill(with: userViewModel)
        case .displayFooterLoader:
            footerView.showLoader()
        }
    }
    
    private func setupNavBar() {
//        self.navigationController?.hidesBarsOnSwipe = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.titleView = titleView
    }
    
    private func setupNewsfeedTableView() {
        view.addSubview(newsfeedTableView)
        newsfeedTableView.addSubview(refreshControl)
        newsfeedTableView.tableFooterView = footerView
        newsfeedTableView.contentInset = Constants.newsfeedtableViewInsets
        newsfeedTableView.separatorStyle = .none
        
        NSLayoutConstraint.activate([
            newsfeedTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newsfeedTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            newsfeedTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            newsfeedTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        newsfeedTableView.delegate = self
        newsfeedTableView.dataSource = self
        newsfeedTableView.register(NewsfeedCell.self, forCellReuseIdentifier: NewsfeedCell.identifier)
    }
    
    @objc private func refresh() {
        interactor?.makeRequest(.getNewsfeed )
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
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y > scrollView.contentSize.height / 1.1 {
            interactor?.makeRequest(.getNextBatch)
        }
    }
}

extension NewsfeedViewController: NewsfeedCellDelegate {
    func revealPost(for cell: NewsfeedCell) {
        guard let indexPath = newsfeedTableView.indexPath(for: cell) else { return }
        let cellViewModel = newsfeedViewModel.newsfeedCells[indexPath.row]
        interactor?.makeRequest(.revealPostIDs(cellViewModel.postId))
    }
}
