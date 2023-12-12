//
//  TasksListHeader.swift
//  Yandex ToDo LIst
//
//  Created by Андрей Соколов on 03.10.2023.
//

import UIKit

class TasksListHeader: UIView {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let doneCountlabel: UILabel = {
       let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let showAllListButton: UIButton = {
       let button = UIButton()
        button.setTitle("Показать", for: .normal)
        button.setTitle("Скрыть", for: .selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private func setupView() {
        
        addSubview(doneCountlabel)
        addSubview(showAllListButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            doneCountlabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            doneCountlabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            showAllListButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            showAllListButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
}
