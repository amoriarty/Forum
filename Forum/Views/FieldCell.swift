//
//  FieldCell.swift
//  Forum
//
//  Created by Émilie Legent on 03/01/2018.
//  Copyright © 2018 Alexandre Legent. All rights reserved.
//

import UIKit

class FieldCell: UITableViewCell {
    var placeholder: String? {
        didSet { textField.placeholder = placeholder }
    }
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .purple
        textField.font = .futura(ofSize: 25)
        return textField
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(textField)
        
        _ = textField.fill(self, constant: 5)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {}
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {}
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
