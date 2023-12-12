//
//  MainView.swift
//  Yandex ToDo LIst
//
//  Created by Андрей Соколов on 01.10.2023.
//

import UIKit

class MainView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupMainView()
        setupViews()
        setupConstrains()
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
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.textContainer.maximumNumberOfLines = 0
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.text = "Что надо сделать ?"
        textView.isScrollEnabled = false
        textView.backgroundColor = .white
        textView.layer.cornerRadius = 15
        textView.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let insideTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .brown
        tableView.isScrollEnabled = false
        tableView.layer.cornerRadius = 15
        tableView.separatorInset.right = 16
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let importanceCell = ImportanceCell()
    let deadlineCell = DeadlineCell()
    let datepickerCell = DatePickerCell()
    
    func setupTableViewHeight() {
        insideTableView.heightAnchor.constraint(equalToConstant: CGFloat(insideTableView.contentSize.height)).isActive = true
    }
    
    let deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Delete", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(UIColor.red, for: .normal)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private func setupMainView() {
        backgroundColor = .systemGray6
    }
    
    private func setupViews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(textView)
        contentView.addSubview(insideTableView)
        contentView.addSubview(deleteButton)
    }
    
    private func setupConstrains() {
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
            
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            textView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 12),
            textView.heightAnchor.constraint(greaterThanOrEqualToConstant: 120),
            textView.bottomAnchor.constraint(equalTo: insideTableView.topAnchor, constant: -16),
            
            insideTableView.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 16),
            insideTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            insideTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            insideTableView.bottomAnchor.constraint(equalTo: deleteButton.topAnchor, constant: -16),
            insideTableView.heightAnchor.constraint(greaterThanOrEqualToConstant: 439),
            
            deleteButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            deleteButton.topAnchor.constraint(equalTo: insideTableView.bottomAnchor,constant: 16),
            deleteButton.heightAnchor.constraint(equalToConstant: 56),
            deleteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

        ])
    }
}
