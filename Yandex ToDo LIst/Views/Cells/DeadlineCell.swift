//
//  DeadlineCell.swift
//  Yandex ToDo LIst
//
//  Created by Андрей Соколов on 25.09.2023.
//

import UIKit

class DeadlineCell: UITableViewCell {

    let indexPath = IndexPath(row: 1, section: 1)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let deadlineLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.text = "Сделать до"
        return label
    }()
    
    let deadlineButton: UIButton = {
        let button = UIButton()
        button.setTitle("2 июня 2021", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        return button
    }()
    
    let deadlineSwitch: UISwitch = {
        let deadlineSwitch = UISwitch()
        deadlineSwitch.translatesAutoresizingMaskIntoConstraints = false
        return deadlineSwitch
    }()
    
    let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    
    func setupView() {
        selectionStyle = .none
        backgroundColor = UIColor(named: "cellColor")
        contentView.addSubview(verticalStackView)
        contentView.addSubview(deadlineSwitch)
        verticalStackView.addArrangedSubview(deadlineLable)
        verticalStackView.addArrangedSubview(deadlineButton)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),//6
            verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            verticalStackView.trailingAnchor.constraint(equalTo: deadlineSwitch.leadingAnchor, constant: -16),
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10), //-6
            
            deadlineSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            deadlineSwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
        ])
    }
}
