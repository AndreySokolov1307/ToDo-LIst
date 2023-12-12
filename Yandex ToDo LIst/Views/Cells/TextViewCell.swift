//
//  TextViewCell.swift
//  Yandex ToDo LIst
//
//  Created by Андрей Соколов on 24.09.2023.
//

import UIKit

class TextViewCell: UITableViewCell, UITextViewDelegate {
    
    let indexPath = IndexPath(row: 0, section: 0)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.textContainer.maximumNumberOfLines = 0
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.isScrollEnabled = false
        textView.returnKeyType = .go
        textView.backgroundColor = UIColor(named: "cellColor")
        textView.enablesReturnKeyAutomatically = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private func setupView() {
        backgroundColor = UIColor(named: "cellColor")
        selectionStyle = .none
        contentView.addSubview(textView)
    }

    private func setupConstrains() {
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            textView.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor),
        ])
    }
    
}
