//
//  PopupView.swift
//  Forum
//
//  Created by Émilie Legent on 03/01/2018.
//  Copyright © 2018 Alexandre Legent. All rights reserved.
//

import UIKit

class PopupView: UIView {
    weak var controller: PopupController? {
        didSet {
            tableView.delegate = controller
            tableView.dataSource = controller
        }
    }
    
    private let navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = .forumWhite
        
        let navigationItem = UINavigationItem()
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(handleCancel))
        let addButton = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(handleAdd))
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = addButton
        navigationBar.setItems([navigationItem], animated: true)
        
        return navigationBar
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        layer.cornerRadius = 5
        clipsToBounds = true
        addSubview(tableView)
        addSubview(navigationBar)
        setupLayouts()
    }
    
    private func setupLayouts() {
        _ = tableView.fill(self)
        _ = navigationBar.fill(.horizontaly, self)
        _ = navigationBar.constraint(.top, to: self)
    }
    
    @objc func handleCancel() {
        controller?.cancel()
    }
    
    @objc func handleAdd() {
        controller?.add()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
