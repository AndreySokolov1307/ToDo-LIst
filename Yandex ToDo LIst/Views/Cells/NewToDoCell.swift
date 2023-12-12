//
//  NewToDoCell.swift
//  Yandex ToDo LIst
//
//  Created by Андрей Соколов on 04.10.2023.
//

import UIKit

class NewToDoCell: UITableViewCell {
    
    static let identifier = "NewToDoCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let newToDoLabel: UILabel = {
       let label = UILabel()
        label.text = "Новое"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupView() {
        accessoryType = .disclosureIndicator
        contentView.addSubview(newToDoLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            newToDoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 52),
            newToDoLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            newToDoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            newToDoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 56)
        ])
    }
    
}
