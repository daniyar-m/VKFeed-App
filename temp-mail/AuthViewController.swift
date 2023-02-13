//  Created by Daniyar Mamadov on 13.02.2023.

import UIKit

final class AuthViewController: UIViewController {
    
    private var authService: AuthService!
    
    private lazy var loginButton: UIButton = {
        let view = UIButton()
        view.setTitle("Войти в VK", for: .normal)
        view.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        view.backgroundColor = .blue
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.titleLabel?.font = .systemFont(ofSize: 24, weight: .medium)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 200),
            loginButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        authService = SceneDelegate.shared().authService
        print(authService)
    }
    
    @objc private func loginButtonTapped() {
        authService?.wakeUpSession()
    }
}
