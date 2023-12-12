//
//  ImportanceCell.swift
//  Yandex ToDo LIst
//
//  Created by Андрей Соколов on 25.09.2023.
//

import UIKit

class ImportanceCell: UITableViewCell {

    let indexPath = IndexPath(row: 0, section: 1)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let importanceLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.text = "Важность"
        return label
    }()
    
    let importanceSegmentControl: UISegmentedControl = {
        let segmentConttol = UISegmentedControl()
        
        let colorsConfig = UIImage.SymbolConfiguration(paletteColors: [.lightGray])
        let sizeConfig = UIImage.SymbolConfiguration(pointSize: 16,
                                                     weight: UIImage.SymbolWeight.bold,
                                                     scale: UIImage.SymbolScale.medium)
        let arrowImage = UIImage(systemName: "arrow.down",
                                 withConfiguration: colorsConfig.applying(sizeConfig))
        
        let colorsConfig2 = UIImage.SymbolConfiguration(paletteColors: [UIColor.systemRed])
        let sizeConfig2 = UIImage.SymbolConfiguration(pointSize: 16,
                                                      weight: UIImage.SymbolWeight.bold,
                                                      scale: UIImage.SymbolScale.medium)
        let exclamationImage = UIImage(systemName: "exclamationmark.2",
                                       withConfiguration: colorsConfig2.applying(sizeConfig2))
        
        
        
        segmentConttol.insertSegment(with: arrowImage,
                                     at: 0,
                                     animated: true)
        segmentConttol.insertSegment(withTitle: "нет",
                                     at: 1,
                                     animated: true)
        segmentConttol.insertSegment(with: exclamationImage,
                                     at: 2,
                                     animated: true)
        
        return segmentConttol
    }()
    
    
    let horisontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private func setupView() {
        selectionStyle = .none
        backgroundColor = UIColor(named: "cellColor")
        contentView.addSubview(horisontalStackView)
        horisontalStackView.addArrangedSubview(importanceLable)
        horisontalStackView.addArrangedSubview(importanceSegmentControl)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            horisontalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            horisontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            horisontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            horisontalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
