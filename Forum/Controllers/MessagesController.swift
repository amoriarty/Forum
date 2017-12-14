//
//  MessagesController.swift
//  Forum
//
//  Created by Alexandra Legent on 14/12/2017.
//  Copyright © 2017 Alexandre Legent. All rights reserved.
//

import UIKit

class MessagesController: UITableViewController {
    private let reuseId = "reusId"
    var topic: Topic?
    var messages = [Message]() {
        didSet { tableView.reloadData() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        messages = []
        
        guard let topic = topic else { return }
        APIService.shared.getMessage(for: topic) { messages in
            guard let messages = messages else { return }
            self.messages = messages
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath)
//        let message = messages[indexPath.item]
//        cell.textLabel?.text = message.content
        return cell
    }
}
