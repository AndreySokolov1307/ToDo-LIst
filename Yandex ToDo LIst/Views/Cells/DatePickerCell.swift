//
//  DatePickerCell.swift
//  Yandex ToDo LIst
//
//  Created by Андрей Соколов on 25.09.2023.
//

import UIKit

class DatePickerCell: UITableViewCell {

    let indexPath = IndexPath(row: 2, section: 1)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.locale = .current
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    private func setupView() {
        selectionStyle = .none
        backgroundColor = UIColor(named: "cellColor")
        contentView.addSubview(datePicker)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            datePicker
                .topAnchor.constraint(equalTo: contentView.topAnchor),
            datePicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            datePicker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
//MARK: - Animation for cell appear and dissapear states
    func fadeAnimationCellAppear() {
        self.alpha = 0
        UIView.animate(withDuration: 0.5,
                       delay: 0.05,
                       animations: {
            self.alpha = 1
        })
    }
    
    func fadeAnimationCellDissapear(with completion: ((Bool) -> Void)?) {
        self.alpha = 1
        UIView.animate(withDuration: 0.3,
                       delay: 0.05,
                       options: [],
                       animations: {
            self.alpha = 0
        },
                       completion: completion)
    }
}
