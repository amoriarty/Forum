//
//  Message.swift
//  Forum
//
//  Created by Alexandra Legent on 14/12/2017.
//  Copyright © 2017 Alexandre Legent. All rights reserved.
//

import Foundation

struct Message: Decodable {
    let author: Student
    let content: String
    let createdAt: String
    let replies: [Message]
    let votes: Vote
    let isReply: Bool?
    
    private enum CodingKeys: CodingKey, String {
        case author, content, replies, isReply
        case createdAt = "created_at"
        case votes = "votes_count"
    }
}
