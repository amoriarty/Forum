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
    private let popupController = PopupController()
    private var topics = [Topic]() {
        didSet { tableView.reloadData() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Topics"
        setupTableView()
        setupNavBar()
        handleLogout()
        LoginService.shared.delegate = self
    }
    
    private func setupTableView() {
        tableView.register(TopicCell.self, forCellReuseIdentifier: reuseId)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
    }
    
    private func setupNavBar() {
        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
        navigationItem.leftBarButtonItem = logoutButton
        navigationItem.rightBarButtonItem = addButton
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as! TopicCell
        let topic = topics[indexPath.item]
        cell.topic = topic
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        messagesController.topic = topics[indexPath.item]
        navigationController?.pushViewController(messagesController, animated: true)
    }
    
    @objc func handleLogout() {
        navigationController?.present(loginController, animated: true, completion: nil)
    }
    
    @objc func handleAdd() {
        guard let window = UIApplication.shared.keyWindow else { return }
        window.addSubview(popupController.view)
        
//        popupController.modalPresentationStyle = .overCurrentContext
//        navigationController?.present(popupController, animated: true, completion: nil)
    }
    
    func didLogin() {
        navigationController?.dismiss(animated: true, completion: nil)
        APIService.shared.getTopics { topics in
            guard let topics = topics else { return }
            self.topics = topics
        }
    }
}

