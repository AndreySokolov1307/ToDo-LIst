//
//  TaskView.swift
//  Yandex ToDo LIst
//
//  Created by Андрей Соколов on 23.09.2023.
//

import UIKit

class WithoutTableViewView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTaskView()
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   private let scrollView: UIScrollView = {
        var scrollView = UIScrollView()
        scrollView.backgroundColor = .green
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .magenta
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.backgroundColor = .systemGray5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.textContainer.maximumNumberOfLines = 0
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.text = "Что надо сделать ?"
        
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let textViewStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 0
        
        stackView.backgroundColor = .systemMint
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let insideStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
        stackView.alignment = .fill
            stackView.distribution = .fill
            stackView.spacing = 10
            stackView.layer.cornerRadius = 15
            stackView.backgroundColor = .systemMint
            stackView.translatesAutoresizingMaskIntoConstraints = false
  
            return stackView
        }()
    
    let importanceHorizontalStack:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 1
        stackView.backgroundColor = .systemGray3
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let importanceLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.text = "Importance"
        return label
    }()
    
    let ImportanceSegmentControl: UISegmentedControl = {
        let segmentConttol = UISegmentedControl()
        segmentConttol.insertSegment(withTitle: "0", at: 0, animated: true)
        segmentConttol.insertSegment(withTitle: "1", at: 1, animated: true)
        segmentConttol.insertSegment(withTitle: "2", at: 2, animated: true)
        return segmentConttol
    }()
    
    let deadlineHorizontalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.spacing = 10
        stackView.backgroundColor = .systemGray4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let vert2Stack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = -4
        stackView.backgroundColor = .systemGray4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let deadlineLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.text = "Deadline"
        return label
    }()
    
    let deadlineSwitch: UISwitch = {
        let deadlineSwitch = UISwitch()
        return deadlineSwitch
    }()
    
    let deadlineButton: UIButton = {
        let button = UIButton()
        button.setTitle("10.10.2010", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        return button
    }()
    
    let calendar: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.locale = .current
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        return datePicker
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Delete", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(UIColor.red, for: .normal)
        button.layer.cornerRadius = 15
        return button
    }()
    
    let separator: UIView = {
        let separator = UIView()
        separator.backgroundColor = .black
        
        
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    func setupTaskView() {
        backgroundColor = UIColor(red: 0.97,
                                  green: 0.97,
                                  blue: 0.95,
                                  alpha: 1.0 )
        backgroundColor = .brown
       
    }
    
    func setupViews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(textViewStack)
        textViewStack.addArrangedSubview(textView)
        mainStackView.addArrangedSubview(insideStackView)
        insideStackView.addArrangedSubview(importanceHorizontalStack)
        importanceHorizontalStack.addArrangedSubview(importanceLable)
        importanceHorizontalStack.addArrangedSubview(ImportanceSegmentControl)
        insideStackView.addArrangedSubview(separator)
        insideStackView.addArrangedSubview(deadlineHorizontalStack)
        deadlineHorizontalStack.addArrangedSubview(vert2Stack)
        deadlineHorizontalStack.addArrangedSubview(deadlineSwitch)
        vert2Stack.addArrangedSubview(deadlineLable)
        vert2Stack.addArrangedSubview(deadlineButton)
                
        insideStackView.addArrangedSubview(calendar)
        mainStackView.addArrangedSubview(deleteButton)
        
    }
    
    func setConstraints() {
        
    
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 16),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            textView.heightAnchor.constraint(equalToConstant: 120),
            
            separator.heightAnchor.constraint(equalToConstant: 0.5),
//            separator.widthAnchor.constraint(equalToConstant: 200)
            
            
            
            

//            hor1stack.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 16),
//            hor1stack.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -16),
//
//
//            hor2stack.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 16),
//            hor2stack.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -16),
//
//            calendar.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 16),
//            calendar.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -16),
            
            
            
            
//
//            textView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 12),
//            textView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -12),
            //textView.topAnchor.constraint(equalTo: mainStackView.topAnchor)
            
//            textView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.2),
//            hor1stack.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.1),
//            hor2stack.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.1),
//            deleteButton.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.1),
//
        ])
    }
    
    
    
}
