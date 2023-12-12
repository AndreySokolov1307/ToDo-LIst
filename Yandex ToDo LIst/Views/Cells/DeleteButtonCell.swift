//
//  DeleteButtonCell.swift
//  Yandex ToDo LIst
//
//  Created by Андрей Соколов on 25.09.2023.
//

import UIKit

class DeleteButtonCell: UITableViewCell {

    let indexPath = IndexPath(row: 0, section: 2)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConatrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Удалить", for: .normal)
        button.backgroundColor = UIColor(named: "cellColor")
        button.setTitleColor(UIColor.systemRed, for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .disabled)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private func setupView() {
        selectionStyle = .none
        backgroundColor = UIColor(named: "cellColor")
        contentView.addSubview(deleteButton)
    }
    
    private func setupConatrains() {
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            deleteButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
