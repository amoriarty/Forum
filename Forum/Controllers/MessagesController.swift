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
    var messages = [Message]() {
        didSet { tableView.reloadData() }
    }
    
    var topic: Topic? {
        didSet {
            messages = []
    
            guard let topic = topic else { return }
            title = topic.name
            APIService.shared.getMessage(for: topic) { messages in
                guard let messages = messages else { return }
                self.setMessages(messages)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.register(MessageCell.self, forCellReuseIdentifier: reuseId)
    }
    
    func setMessages(_ messages: [Message]) {
        var final = [Message]()
        
        messages.forEach { item in
            final.append(item)
            
            item.replies.forEach({ reply in
                let toAppend = Message(author: reply.author, content: reply.content, createdAt: reply.createdAt, replies: reply.replies, votes: reply.votes, isReply: true)
                final.append(toAppend)
            })
        }
        
        self.messages = final
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as! MessageCell
        let message = messages[indexPath.item]
        cell.message = message
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let message = messages[indexPath.item]
        let size = CGSize(width: tableView.frame.width - 65, height: 10000)
        let attributedContent = NSAttributedString(string: message.content, attributes: [.font: UIFont.futuraBook(ofSize: 14)])
        let estimatedFrame = attributedContent.boundingRect(with: size, options: .usesLineFragmentOrigin, context: nil)
        let estimatedHeight = estimatedFrame.height + 30
        
        return estimatedHeight > 60 ? estimatedHeight : 60
    }
}
