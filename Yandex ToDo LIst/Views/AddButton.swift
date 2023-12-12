//
//  AddButton.swift
//  Yandex ToDo LIst
//
//  Created by Андрей Соколов on 13.10.2023.
//

import UIKit

class AddButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        layer.cornerRadius = 22
        backgroundColor = .systemBlue
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 8)
        layer.shadowOpacity = 1
        layer.shadowRadius = 20
        let colorsConfig = UIImage.SymbolConfiguration(paletteColors: [.white])
        let sizeConfig = UIImage.SymbolConfiguration(pointSize: 26,
                                                     weight: UIImage.SymbolWeight.medium,
                                                     scale: UIImage.SymbolScale.default)
        let plusImage = UIImage(systemName: "plus",
                                withConfiguration: colorsConfig.applying(sizeConfig))
        setImage(plusImage, for: .normal)
    }
}
