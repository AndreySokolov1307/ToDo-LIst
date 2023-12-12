//
//  NewTaskTableViewController.swift
//  Yandex ToDo LIst
//
//  Created by Андрей Соколов on 24.09.2023.
//

import UIKit

protocol AddOrDeleteToDoItemDelegate: AnyObject {
    func addToDoItem(_ toDoItem: ToDoItem)
    func deleteToDoItem(_ toDoItem: ToDoItem)
}

class NewTaskTableViewController: UITableViewController {
    
    var toDoItem: ToDoItem?
   
    weak var delegate: AddOrDeleteToDoItemDelegate?
        
    private let textViewCell = TextViewCell()
    private let importanceCell = ImportanceCell()
    private let deadlineCell = DeadlineCell()
    private let datePickerCell = DatePickerCell()
    private let deleteButtonCell = DeleteButtonCell()
    
    private var isDatePickerHidden = true
    private var isLoadDataSuccesfull = false
    private lazy var nextDay = Calendar.current.date(byAdding: .day,
                                                     value: 1,
                                                     to: Date())
    init(toDoItem: ToDoItem?) {
        super.init(style: .insetGrouped)
        self.toDoItem = toDoItem
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        updateUI()
        addActions()
        dismissKeyboardOnTap()
    }
    
 
    private func updateUI() {
        if let toDoItem = toDoItem {
            textViewCell.textView.text = toDoItem.text
            
            switch toDoItem.importanceRate {
            case .low:
                importanceCell.importanceSegmentControl.selectedSegmentIndex = 0
            case .normal:
                importanceCell.importanceSegmentControl.selectedSegmentIndex = 1
            case .hight:
                importanceCell.importanceSegmentControl.selectedSegmentIndex = 2
            }
            
            if let deadline = toDoItem.deadline {
                deadlineCell.deadlineSwitch.isOn = true
                deadlineCell.deadlineButton.isHidden = false
                updateDeadlineButtonTitle(with: deadline)
                datePickerCell.datePicker.date = deadline
            } else {
                deadlineCell.deadlineSwitch.isOn = false
                deadlineCell.deadlineButton.isHidden = true
            }
            navigationItem.rightBarButtonItem?.isEnabled = true
            
        } else {
            textViewCell.textView.text = "Что надо сделать ?"
            textViewCell.textView.textColor = .lightGray
            
            importanceCell.importanceSegmentControl.selectedSegmentIndex = 2
            
            deadlineCell.deadlineSwitch.isOn = false
            deadlineCell.deadlineButton.isHidden = true
            
            updateDeadlineButtonTitle(with: nextDay)
            
            datePickerCell.datePicker.date = Date()
            
            deleteButtonCell.deleteButton.isEnabled = false
        }
    }
    
    private func addActions() {
        deadlineCell.deadlineButton.addTarget(self,
                                              action: #selector(didTapDeadlineButton),
                                              for: .touchUpInside)
    
        deadlineCell.deadlineSwitch.addTarget(self,
                                              action: #selector(didChangeSwitchValue),
                                              for: .valueChanged)
        
        datePickerCell.datePicker.addTarget(self,
                                            action: #selector(datePickerValueChanged),
                                            for: .valueChanged)
        
        deleteButtonCell.deleteButton.addTarget(self,
                                                action: #selector(didTapDeleteButton),
                                                for: .touchUpInside)
    }
 
    private func setupNavigationBar() {
        navigationItem.title = "Дело"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(didTapCancelButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didTapSaveButton))
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: tableView.frame, style: .insetGrouped)
        tableView.separatorInset.left = 16
        tableView.separatorInset.right = 16
        tableView.backgroundColor = UIColor(named: ColorName.viewColor)
        tableView.sectionHeaderHeight = 0 // override method doesnt work without setting here
        tableView.sectionFooterHeight = 0 // changed at heightForHeader ... method
    }
    
    @objc func didTapCancelButton() {
        dismiss(animated: true)
    }
    
    @objc func didTapSaveButton() {

        let text = textViewCell.textView.text!
        let importanceRate: ToDoItem.Importance = {
            switch self.importanceCell.importanceSegmentControl.selectedSegmentIndex {
            case 0:
                return ToDoItem.Importance.low
            case 1:
                return ToDoItem.Importance.normal
            case 2:
                return ToDoItem.Importance.hight
            default:
                return ToDoItem.Importance.normal
            }
        }()
        let deadline =  {
            return deadlineCell.deadlineSwitch.isOn ? datePickerCell.datePicker.date : nil
        }()
        let isDone = false
        let modificationDate = Date()
        
        if toDoItem != nil {
            let modifiedTask = ToDoItem(id: toDoItem!.id,
                                        text: text,
                                        importanceRate: importanceRate,
                                        deadline: deadline,
                                        isDone: isDone,
                                        creationDate: toDoItem!.creationDate,
                                        modificationDate: modificationDate)
            delegate?.addToDoItem(modifiedTask)
            self.dismiss(animated: true)
            print("save modified")
        } else {
            let newTask = ToDoItem(text: text,
                                   importanceRate: importanceRate,
                                   deadline: deadline,
                                   isDone: isDone,
                                   creationDate: Date(),
                                   modificationDate: nil)
            delegate?.addToDoItem(newTask)
            self.dismiss(animated: true)
            print("save new")
        }
    }
    
    @objc func didTapDeadlineButton() {
        isDatePickerHidden.toggle()
        datePickerCell.fadeAnimationCellDissapear { (_) in
            self.tableView.reloadData()
        }

    }
    
    private func updateDeadlineButtonTitle(with date: Date?) {
        guard let date = date else {return}
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.locale = .current
        let title = dateFormatter.string(from: date)
        deadlineCell.deadlineButton.setTitle(title, for: .normal)
    }
    
    @objc func didChangeSwitchValue(_ sender: UISwitch) {
        deadlineCell.deadlineButton.isHidden.toggle()
        datePickerCell.datePicker.date = nextDay!
        updateDeadlineButtonTitle(with: nextDay)
    }
    
    @objc func datePickerValueChanged(_ datePicker: UIDatePicker) {
        updateDeadlineButtonTitle(with: datePicker.date)
    }
    
    @objc func didTapDeleteButton() {
        if let toDoItem = toDoItem {
            delegate?.deleteToDoItem(toDoItem)
            self.dismiss(animated: true)
        }
    }
        
    //Make keyboard disapear on tap
    func dismissKeyboardOnTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            if isDatePickerHidden == true {
                return 2
            } else {
                return 3
            }
        case 2:
            return 1
        default: fatalError("Unknown number of section")
        }
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            self.textViewCell.textView.delegate = self
            self.textViewCell.textView.heightAnchor.constraint(greaterThanOrEqualToConstant: 92 ).isActive = true
            
            return self.textViewCell
            
        case 1:
            switch indexPath.row {
            case 0: return self.importanceCell
            case 1: return self.deadlineCell
            case 2 where !isDatePickerHidden: return self.datePickerCell
            default: fatalError("Unknown number of rows")
            }
        case 2:
            return self.deleteButtonCell
        default: fatalError("Unknown number of rows")
        }
    }
    
//MARK: - TableView HeightForRow and HeightForHeader
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath{
        case importanceCell.indexPath,
            deadlineCell.indexPath,
            deleteButtonCell.indexPath:
            return 56
        default: return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       return 16
    }
    
 
    //MARK: - Animation for datePicker
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath == datePickerCell.indexPath && datePickerCell.isHidden == false {
            datePickerCell.fadeAnimationCellAppear()
        }
    }
   
}

//MARK: - UITextViewDelegate

extension NewTaskTableViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if !textView.text.isEmpty {
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
        if textView.text == "" {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    //Making placeholder for textView
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = UIColor(named: ColorName.textViewColor)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Что надо сделать?"
            textView.textColor = .lightGray
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
}

//для того чтобы клавиатура сворачивалась при нажатии РЕТУРН клавиши
    
//      func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//          if (text as NSString).rangeOfCharacter(from: CharacterSet.newlines).location == NSNotFound {
//              return true
//          }
//          textView.resignFirstResponder()
//          return false
//      }


