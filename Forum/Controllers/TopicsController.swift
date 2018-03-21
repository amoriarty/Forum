//
//  TopicsController.swift
//  Forum
//
//  Created by Alexandra Legent on 05/12/2017.
//  Copyright © 2017 Alexandre Legent. All rights reserved.
//

import UIKit

class TopicsController: UITableViewController, LoginDelegate {
    private let reuseId = "reuseId"
    private let loginController = LoginController()
    private let messagesController = MessagesController()
    private let popupController = AddTopicController()
    private var topics = [Topic]() {
        didSet { tableView.reloadData() }
    }
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Topics"
        setupTableView()
        setupNavBar()
        handleLogout()
        LoginService.shared.delegate = self
    }
    
    // MARK:- Setups
    private func setupTableView() {
        tableView.register(TopicCell.self, forCellReuseIdentifier: reuseId)
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
    }
    
    private func setupNavBar() {
        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
        navigationItem.leftBarButtonItem = logoutButton
        navigationItem.rightBarButtonItem = addButton
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK:- Table View Delegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as! TopicCell
        let topic = topics[indexPath.item]
        cell.topic = topic
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let topic = topics[indexPath.item]
        
        let size = CGSize(width: tableView.frame.width - 90, height: 10000)
        let estimatedFrame = TopicCell.getAttributedText(for: topic).boundingRect(with: size, options: .usesLineFragmentOrigin, context: nil)
        return estimatedFrame.height > 85 ? estimatedFrame.height : 85
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        messagesController.topic = topics[indexPath.item]
        navigationController?.pushViewController(messagesController, animated: true)
    }
    
    // MARK:- Buttons handler
    @objc func handleLogout() {
        navigationController?.present(loginController, animated: true, completion: nil)
    }
    
    @objc func handleAdd() {
        guard let window = UIApplication.shared.keyWindow else { return }
        window.addSubview(popupController.view)
    }
    
    // MARK:- Refresh handler
    @objc func handleRefresh() {
        APIService.shared.getTopics { [unowned self] topics in
            guard let topics = topics else { return }
            self.topics = topics
            self.refreshControl?.endRefreshing()
        }
    }
    
    // MARK:- Login Delegate
    func didLogin() {
        navigationController?.dismiss(animated: true, completion: nil)
        handleRefresh()
    }
}

