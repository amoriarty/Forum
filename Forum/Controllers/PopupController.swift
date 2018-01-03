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

class PopupController: UIViewController {
    private let animationDuration = 0.5
    weak var delegate: PopupDelegate?
    private let popupView = PopupView()
    private var constraints = [NSLayoutAttribute: NSLayoutConstraint]()
    
    private let background: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.alpha = 0
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        view.addSubview(background)
        view.addSubview(popupView)
        setupLayouts()
        
        popupView.controller = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        constraints[.top]?.isActive = false
        constraints[.bottom]?.isActive = true
        
        UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.background.alpha = 0.4
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func setupLayouts() {
        _ = background.fill(view)
        _ = popupView.fill(.horizontaly, view.safeAreaLayoutGuide)
        _ = popupView.constraint(.height, to: view, multiplier: 0.90)

        constraints[.top] = popupView.constraint(.top, to: view, .bottom)
        constraints[.bottom] = popupView.constraint(.bottom, to: view, active: false)
    }
    
    func add() {
        print("add something (func to override)")
    }
    
    func cancel() {
        constraints[.bottom]?.isActive = false
        constraints[.top]?.isActive = true
        
        UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.background.alpha = 0
            self.view.layoutIfNeeded()
        }) { _ in
            self.view.removeFromSuperview()
        }
    }
}
