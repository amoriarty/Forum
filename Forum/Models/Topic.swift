//
//  Topic.swift
//  Forum
//
//  Created by Alexandra Legent on 05/12/2017.
//  Copyright © 2017 Alexandre Legent. All rights reserved.
//

import Foundation

struct Topic: Decodable {
    let id: Int
    let name: String
    let author: Student
    let createdAt: String
    
    private enum CodingKeys: CodingKey, String {
        case id, name, author
        case createdAt = "created_at"
    }
}

struct SendableTopic: Encodable {
    let name: String
    let messagesAttributes: MessagesAttributes
    
    struct MessagesAttributes: Encodable {
        let content: String
    }
    
    init(name: String, content: String) {
        self.name = name
        self.messagesAttributes = MessagesAttributes(content: content)
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case messagesAttributes = "messages_attributes"
    }
}
