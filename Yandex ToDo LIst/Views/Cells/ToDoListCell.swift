//
//  ToDoListCell.swift
//  Yandex ToDo LIst
//
//  Created by Андрей Соколов on 03.10.2023.
//

import UIKit

class ToDoListCell: UITableViewCell {
    
    static let identifier = "ToDoCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let isCompleteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    static func setImageForToDoState(_ isDone: Bool, _ importance: ToDoItem.Importance) -> UIImage {
        if isDone {
            return UIImage(named: "greenCircle")!
        } else {
            if importance == .hight {
                 return UIImage(named: "redCircle")!
            } else {
                return UIImage(named: "grayCircle")!
            }
        }
    }
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 3
        return label
    }()
    
    let deadlineLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .lightGray
        label.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
        return label
    }()
    
    let importanceImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let calendarImageView: UIImageView = {
        let imageView = UIImageView()
        let colorConfig = UIImage.SymbolConfiguration(paletteColors: [UIColor.lightGray])
        let sizeConfig = UIImage.SymbolConfiguration(pointSize: 15,
                                                     weight: UIImage.SymbolWeight.regular,
                                                     scale: UIImage.SymbolScale.default)
        let calendarImage = UIImage(systemName: "calendar",
                                       withConfiguration: colorConfig.applying(sizeConfig))
        imageView.image = calendarImage
        return imageView
    }()
    
    
    let mainHorisontalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        return stackView
    }()
    
    let deadlineDateHorisontalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 2
        return stackView
    }()
    
    private func setupView() {
        accessoryType = .disclosureIndicator
        contentView.addSubview(isCompleteImageView)
        contentView.addSubview(mainHorisontalStack)
        mainHorisontalStack.addArrangedSubview(importanceImageView)
        mainHorisontalStack.addArrangedSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(deadlineDateHorisontalStack)
        deadlineDateHorisontalStack.addArrangedSubview(calendarImageView)
        deadlineDateHorisontalStack.addArrangedSubview(deadlineLabel)
        
        importanceImageView.isHidden = true
        deadlineDateHorisontalStack.isHidden = true
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            isCompleteImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            isCompleteImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
           
            
            mainHorisontalStack.leadingAnchor.constraint(equalTo: isCompleteImageView.trailingAnchor, constant: 12),
            mainHorisontalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainHorisontalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
        ])
        
        //Вот это пришлось сделать чтобы не вылезала ошибка с UIView Encapsulated LAyout Height ... когда добавлял или удалял Селлс и нажимал кнопку показать/скрыть
        let z = mainHorisontalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        z.isActive = true
        z.priority = UILayoutPriority(999)
        
        let v = contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 56)
        v.isActive = true
        v.priority = UILayoutPriority(999)
    }
}
