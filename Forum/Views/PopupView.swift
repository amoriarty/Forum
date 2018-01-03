//
//  PopupView.swift
//  Forum
//
//  Created by Émilie Legent on 03/01/2018.
//  Copyright © 2018 Alexandre Legent. All rights reserved.
//

import UIKit

class PopupView: UIView {
    weak var controller: PopupController?
    
    let navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        let navigationItem = UINavigationItem()
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(handleCancel))
        let addButton = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(handleAdd))
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
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
        layer.cornerRadius = 15
        clipsToBounds = true
        
        addSubview(navigationBar)
        addSubview(tableView)
        setupLayouts()
    }
    
    private func setupLayouts() {
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
