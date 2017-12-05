//
//  TopicsController.swift
//  Forum
//
//  Created by Alexandra Legent on 05/12/2017.
//  Copyright © 2017 Alexandre Legent. All rights reserved.
//

import UIKit

class TopicsController: UIViewController {
    let loginController = LoginController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.leftBarButtonItem = logoutButton
        
        present(loginController, animated: true, completion: nil)
    }
    
    @objc func handleLogout() {
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }
}

