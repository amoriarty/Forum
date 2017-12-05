//
//  TopicsController.swift
//  Forum
//
//  Created by Alexandra Legent on 05/12/2017.
//  Copyright © 2017 Alexandre Legent. All rights reserved.
//

import UIKit

class TopicsController: UITableViewController, LoginDelegate {
    let reuseId = "reuseId"
    let loginController = LoginController()
    var topics = [Topic]() {
        didSet { tableView.reloadData() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        LoginService.shared.delegate = self
        setupTableView()
        setupNavBar()
        handleLogout()
    }
    
    private func setupNavBar() {
        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.leftBarButtonItem = logoutButton
    }
    
    @objc func handleLogout() {
        navigationController?.present(loginController, animated: true, completion: nil)
    }
    
    func didLogin() {
        navigationController?.dismiss(animated: true, completion: nil)
        APIService.shared.getTopics { topics in
            guard let topics = topics else { return }
            self.topics = topics
        }
    }
}

