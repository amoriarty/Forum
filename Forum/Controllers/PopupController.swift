//
//  PopupController.swift
//  Forum
//
//  Created by Émilie Legent on 02/01/2018.
//  Copyright © 2018 Alexandre Legent. All rights reserved.
//

import UIKit

protocol PopupDelegate: class {
    func dismissPopup()
}

class PopupController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let animationDuration = 0.5
    private let reuseId = "reuseId"
    weak var delegate: PopupDelegate?
    private let popupView = PopupView()
    private var constraints = [NSLayoutAttribute: NSLayoutConstraint]()
    private let fields: [String] = ["Topic Name", "Message"]
    
    private let background: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        return view
    }()
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.addSubview(background)
        view.addSubview(popupView)
        setupLayouts()
        setupPopupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        constraints[.top]?.isActive = false
        constraints[.bottom]?.isActive = true
        
        UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.background.alpha = 0.4
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        /* Setup keyboard observer */
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    // MARK:- Setups
    private func setupLayouts() {
        _ = background.fill(view)
        _ = popupView.fill(.horizontaly, view.safeAreaLayoutGuide)
        _ = popupView.constraint(.height, to: view, multiplier: 0.90)

        constraints[.top] = popupView.constraint(.top, to: view, .bottom)
        constraints[.bottom] = popupView.constraint(.bottom, to: view, active: false)
    }
    
    private func setupPopupView() {
        popupView.controller = self
        popupView.tableView.register(FieldCell.self, forCellReuseIdentifier: reuseId)
        popupView.tableView.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
        popupView.tableView.scrollIndicatorInsets = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
    }
    
    // MARK:- Table View Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId) as! FieldCell
        cell.placeholder = fields[indexPath.item]
        cell.textView.isScrollEnabled = indexPath.item != 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard indexPath.item > 0 else { return 44 }
        return 10000
    }
    
    // MARK:- Buttons Handler
    func add() {
        let topicIndexPath = IndexPath(item: 0, section: 0)
        let messageIndexPath = IndexPath(item: 1, section: 0)
        guard let topicCell = popupView.tableView.cellForRow(at: topicIndexPath) as? FieldCell else { return }
        guard let messageCell = popupView.tableView.cellForRow(at: messageIndexPath) as? FieldCell else { return }
        guard let topic = topicCell.textView.text, topic.count > 0, topic != "" else { return }
        guard let message = messageCell.textView.text, message.count > 0, message != "" else { return }
        let sendable = SendableTopic(name: topicCell.textView.text, content: messageCell.textView.text)
        APIService.shared.add(topic: sendable)
        cancel()
    }
    
    func cancel() {
        constraints[.bottom]?.isActive = false
        constraints[.top]?.isActive = true
        
        UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { [unowned self] in
            self.background.alpha = 0
            self.view.layoutIfNeeded()
        }) { _ in
            self.view.removeFromSuperview()
        }
    }
    
    // MARK:- Keyboard events
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let frame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect else { return }
        guard let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
        popupView.tableViewConstaints[.bottom]?.constant = frame.height * -1
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { [unowned self] in
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @objc func keyboardWillHide() {
        
    }
}
