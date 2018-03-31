//
//  APIService.swift
//  Forum
//
//  Created by Alexandra Legent on 05/12/2017.
//  Copyright © 2017 Alexandre Legent. All rights reserved.
//

import Foundation

class APIService {
    static let shared = APIService()
    private var topicUrl: String {
      return "\(API_URL)/topics"
    }
    
    private var userUrl: String {
        return "\(API_URL)/users"
    }
    
    func getUser(_ user: String = "me", completion: @escaping (Student?) -> Void) {
        guard let token = LoginService.shared.token else { return }
        guard let url = URL(string: "\(userUrl)/\(user)") else { return }
        var request = URLRequest(url: url)
        
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        DataService.shared.get(request: request, for: Student.self, completion: completion)
    }
    
    func getTopics(completion: @escaping ([Topic]?) -> Void) {
        guard let token = LoginService.shared.token else { return }
        guard let url = URL(string: topicUrl) else { return }
        var request = URLRequest(url: url)
        
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        DataService.shared.get(request: request, for: [Topic].self, completion: completion)
    }
    
    func getMessage(for topic: Topic, completion: @escaping ([Message]?) -> Void) {
        guard let token = LoginService.shared.token else { return }
        guard let url = URL(string: "\(topicUrl)/\(topic.id)/messages") else { return }
        var request = URLRequest(url: url)
        
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        DataService.shared.get(request: request, for: [Message].self, completion: completion)
    }
    
    func add(topic name: String, message: String, kind: SendableTopic.TopicKind = .normal, completion: @escaping (Topic?) -> Void) {
        guard let token = LoginService.shared.token else { return }
        guard let url = URL(string: "\(API_URL)/topics") else { return }
        var request = URLRequest(url: url)
        let body = SendableTopic(name: name, content: message, kind: kind)
        
        // Try to encode
        guard let encoded = try? JSONEncoder().encode(body) else { return }
        request.httpMethod = "POST"
        request.httpBody = encoded
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        DataService.shared.get(request: request, for: Topic.self, completion: completion)
    }
    
    func add(message: String, to topic: Int) {
        // TODO: Implement POST message to API
    }
    
    func update(topic: Int, with name: String) {
        // TODO: Implement PATCH topic
    }
    
    func update(message: Int, with content: String) {
        // TODO: Implement PATCH message
    }
    
    func remove(topic: Int) {
        // TODO: Implement DELETE Topic
    }
    
    func remove(message: Int) {
        // TODO: Implement DELETE message
    }
}
