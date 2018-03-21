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
    private let apiUrl = "https://api.intra.42.fr"
    private var topicUrl: String {
      return "\(apiUrl)/v2/topics"
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
    
    func add(topic name: String, message: String) {
        // TODO: Implement POST topic to API.
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
