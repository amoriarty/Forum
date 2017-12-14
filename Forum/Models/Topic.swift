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
