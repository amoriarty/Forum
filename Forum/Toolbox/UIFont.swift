//
//  UIFont.swift
//  Forum
//
//  Created by Alexandra Legent on 05/12/2017.
//  Copyright © 2017 Alexandre Legent. All rights reserved.
//

import UIKit

extension UIFont {
    static func futura(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "FuturaPT-Light", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func futuraBook(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "FuturaPT-Book", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func futuraBold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "FuturaPT-Bold", size: size) ?? .systemFont(ofSize: size)
    }
}
