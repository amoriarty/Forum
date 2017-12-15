//
//  MessageCell.swift
//  Forum
//
//  Created by Alexandra Legent on 14/12/2017.
//  Copyright © 2017 Alexandre Legent. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    var message: Message? {
        didSet {
            guard let message = message else { return }
            
            studentLogin.text = message.author.login
            contentText.text = message.content.trimmingCharacters(in: .whitespacesAndNewlines)
            ImageService.shared.getImage(at: message.author.imageUrl) { image in
                self.studentPicture.image = image
            }
        }
    }
    
    let studentPicture: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let studentLogin: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .futuraBold(ofSize: 14)
        label.textColor = .forumBlue
        return label
    }()
    
    let contentText: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isEditable = false
        view.isSelectable = false
        view.isScrollEnabled = false
        view.textContainerInset = .textViewInsets
        view.font = .futuraBook(ofSize: 14)
        return view
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(studentPicture)
        addSubview(studentLogin)
        addSubview(contentText)
        setupLayouts()
    }
    
    private func setupLayouts() {
        _ = studentPicture.constraint(dimension: .width, constant: 50)
        _ = studentPicture.constraint(.height, to: studentPicture, .width)
        _ = studentPicture.constraint(.top, to: self, constant: 5)
        _ = studentPicture.constraint(.leading, to: self, constant: 5)
        
        _ = studentLogin.constraint(.top, to: studentPicture)
        _ = studentLogin.constraint(.leading, to: studentPicture, .trailing, constant: 5)
        _ = studentLogin.constraint(dimension: .height, constant: 15)
        
        _ = contentText.constraint(.top, to: studentLogin, .bottom, constant: 5)
        _ = contentText.constraint(.leading, to: studentLogin)
        _ = contentText.constraint(.trailing, to: self, constant: 5)
        _ = contentText.constraint(.bottom, to: self, constant: 5)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {}
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
