//
//  LoginService.swift
//  Forum
//
//  Created by Alexandra Legent on 05/12/2017.
//  Copyright © 2017 Alexandre Legent. All rights reserved.
//

import UIKit

protocol LoginDelegate: class {
    func didLogin()
}

class LoginService {
    static let shared = LoginService()
    private let authorizeUrl = "https://api.intra.42.fr/oauth/authorize?client_id=\(API_UID)&redirect_uri=forum%3A%2F%2Fauthorize&response_type=code"
    private var authorization: String?
    weak var delegate: LoginDelegate?
    var isLogin: Bool { return authorization != nil }
    
    func requestAuthorization() {
        guard let url = URL(string: authorizeUrl) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func login(with url: URL) {
        guard let query = url.query else { return }
        guard let results = query.matches(pattern: "([a-z0-9]{63})") else { return }
        guard let code = results.first else { return }
        
        authorization = code
        delegate?.didLogin()
    }
}
