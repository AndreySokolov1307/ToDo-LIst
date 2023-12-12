//
//  TasksListTableViewController.swift
//  Yandex ToDo LIst
//
//  Created by Андрей Соколов on 03.10.2023.
//

import UIKit

class TasksListTableViewController: UITableViewController {
    
    let fileCache = FileCache()
    
    var doneToDos: [ToDoItem] = []
    var allToDos: [ToDoItem] = []
        
    let header = TasksListHeader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fileCache.loadAllTasks()
        allToDos = fileCache.toDoItems.filter { !$0.isDone }
        doneToDos = fileCache.toDoItems.filter { $0.isDone }
        setupNavigationBar()
        setupTableView()
       // definesPresentationContext = true
    }
    
    let addButton = AddButton()
    
    private func setupTableView() {
        tableView = UITableView(frame: tableView.frame, style: .insetGrouped)
        tableView.backgroundColor = UIColor(named: ColorName.viewColor)
        tableView.register(ToDoListCell.self, forCellReuseIdentifier: ToDoListCell.identifier)
        tableView.register(NewToDoCell.self, forCellReuseIdentifier: NewToDoCell.identifier)
        tableView.separatorInset.left = 52
        tableView.addSubview(addButton)
        addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
    }
    
    @objc func didTapAddButton() {
        let controller = NewTaskTableViewController(toDoItem: nil)
        controller.delegate = self
        present(UINavigationController(rootViewController: controller ), animated: true)
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Мои дела"
    }
    
    func updateDeadlineLabelTitle(with date: Date?) -> String {
        guard let date = date else { fatalError() }
        let customFormat = "ddMMMM"
        
        let localFormat = DateFormatter.dateFormat(fromTemplate: customFormat,
                                                   options: 0,
                                                   locale: Locale.current)
        let formatter = DateFormatter()
        formatter.dateFormat = localFormat
        return formatter.string(from: date)
    }
    
    //MARK: - Setup Header
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        header.doneCountlabel.text = "Сделано - \(doneToDos.count)"
        header.showAllListButton.addTarget(self,
                                           action: #selector(didTapShowAllListButton(sender:)),
                                           for: .touchUpInside)
        return header
    }
    
    @objc func didTapShowAllListButton(sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected {
            allToDos = (allToDos + doneToDos).sorted { $0.creationDate < $1.creationDate }
            tableView.reloadData()
        } else {
            let notDoneToDos = allToDos.filter { !$0.isDone }
            allToDos = notDoneToDos
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    //MARK: - Circle addButton
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let off = scrollView.contentOffset.y
        let screenHeight = UIScreen.main.bounds.height
        
        if traitCollection.verticalSizeClass == .compact {
            addButton.center.x = self.view.center.x
            addButton.center.y = self.view.center.y + off + screenHeight/2*0.5
        } else {
            addButton.center.x = self.view.center.x
            addButton.center.y = self.view.center.y + off + screenHeight/2*0.8
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return allToDos.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ToDoListCell.identifier, for: indexPath)
        let newCell = tableView.dequeueReusableCell(withIdentifier: NewToDoCell.identifier, for: indexPath) as! NewToDoCell
        
        if !allToDos.isEmpty && indexPath.row != allToDos.count {
            
            configureCell(cell, forToDoItemAt: indexPath)
            
            return cell
        } else {
            return newCell
        }
    }
    
    private func configureCell(_ cell: UITableViewCell, forToDoItemAt indexPath: IndexPath) {
        guard let cell = cell as? ToDoListCell else { return }
        
        let toDo = allToDos[indexPath.row]
        
        cell.titleLabel.text = toDo.text
        
        if let deadline = toDo.deadline {
            cell.deadlineDateHorisontalStack.isHidden = false
            cell.deadlineLabel.text = updateDeadlineLabelTitle(with: deadline)
        }
        
        switch toDo.importanceRate {
        case .hight:
            cell.importanceImageView.isHidden = false
            cell.importanceImageView.image = UIImage(named: ImageName.highImportance)
        case .low:
            cell.importanceImageView.isHidden = false
            cell.importanceImageView.image = UIImage(named: ImageName.lowImportance)
        case .normal:
            cell.importanceImageView.isHidden = true
        }
        
        cell.isCompleteImageView.image = ToDoListCell.setImageForToDoState(toDo.isDone, toDo.importanceRate)
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if !allToDos.isEmpty && indexPath.row != allToDos.count {
            return true
        } else {
            return false
        }
    }
    
    //MARK: - Leading and trailing swiping actions
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = doneAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [done])
    }
    
    private func doneAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Done") { [weak self] action, view, completion in
            let toDo = self?.allToDos[indexPath.row]
            let doneToDo = ToDoItem(id: toDo!.id,
                                    text: toDo!.text,
                                    importanceRate: toDo!.importanceRate,
                                    deadline: toDo!.deadline,
                                    isDone: true,
                                    creationDate: toDo!.creationDate,
                                    modificationDate: toDo!.modificationDate)
            //Сохраняем все в кэшшш$$$
            self?.fileCache.addNewTask(task: doneToDo)
            self?.fileCache.saveAllTasks()
            
            //Убираем из нашего массива и добавляем в ДАН массив елси его там еще нет
            self?.allToDos.remove(at: indexPath.row)
            if !(self?.doneToDos.contains(doneToDo))! {
                self?.doneToDos.append(doneToDo)
            }
            self?.tableView.deleteRows(at: [indexPath], with: .automatic)
            self?.header.doneCountlabel.text = "Сделано - \(self!.doneToDos.count)"
            self?.tableView.beginUpdates()
            self?.tableView.endUpdates()
            completion(true)
        }
        action.backgroundColor = .systemGreen
        action.image = UIImage(systemName: ImageName.checkmarkCircleFill)
        return action
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        let info = getInfoAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete, info])
    }
    
    private func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let toDoItem = allToDos[indexPath.row]
        let action = UIContextualAction(style: .destructive,
                                        title: "Delete") { [weak self] (action, view, completion) in
            self?.fileCache.removeTaskWithId(id: (self?.fileCache.toDoItems[indexPath.row].id)!)
            self?.allToDos.remove(at: indexPath.row)
            if (self?.doneToDos.contains(toDoItem))! {
                self?.doneToDos.removeAll { $0.id == toDoItem.id }
            }
            self?.tableView.deleteRows(at: [indexPath], with: .fade)
            self?.header.doneCountlabel.text = "Сделано - \(self!.doneToDos.count)"
            self?.tableView.beginUpdates()
            self?.tableView.endUpdates()
            self?.fileCache.saveAllTasks()
            completion(true)
        }
        action.backgroundColor = .systemRed
        action.image = UIImage(systemName: ImageName.trashFill)
        return action
    }
    
    private func getInfoAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive,
                                        title: "info") { [weak self] (action, view, complition) in
            let toDo = self?.allToDos[indexPath.row]
            print("\(toDo!.text)\n\(toDo!.creationDate)")
            complition(true)
        }
        action.backgroundColor = .lightGray
        action.image = UIImage(systemName: ImageName.infoCircleFill)
        return action
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !allToDos.isEmpty && indexPath.row != allToDos.count {
            let controller = NewTaskTableViewController(toDoItem: allToDos[indexPath.row])
            controller.delegate = self
            print("present")
            present(UINavigationController.init(rootViewController: controller), animated: true)

        } else {
            let controller = NewTaskTableViewController(toDoItem: nil)
            controller.delegate = self
            present(UINavigationController(rootViewController: controller ), animated: true)
        }
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        let screenHeight = UIScreen.main.bounds.height
        if traitCollection.verticalSizeClass == .compact {
            addButton.center.x = self.view.center.x
            addButton.center.y = self.view.center.y + screenHeight/2*0.5
        }
    }
    
    //MARK: - ContextMenuConfiguration
    
    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let identifier = NSString(string: String(indexPath.row))
        let controller: UIViewController
        if !allToDos.isEmpty && indexPath.row != allToDos.count {
             controller = UINavigationController(rootViewController: NewTaskTableViewController(toDoItem: allToDos[indexPath.row]))
        } else {
             controller = UINavigationController(rootViewController: NewTaskTableViewController(toDoItem: nil))
        }
        
        return UIContextMenuConfiguration(identifier: identifier, previewProvider: {
            return controller
        }) { actions in
            return  self.makeDefaultMenu()
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
        
        let indexPathString = configuration.identifier as? String
        let indexPath = Int(indexPathString!)
        
        if !allToDos.isEmpty && indexPath != allToDos.count {
            let controller = NewTaskTableViewController(toDoItem: allToDos[indexPath!])
            controller.delegate = self
            //без этого не дает презентить пишет олреди презентинг
            animator.addAnimations {
                self.present(UINavigationController(rootViewController: controller), animated: true)
            }
        } else {
            let controller = NewTaskTableViewController(toDoItem: nil)
            controller.delegate = self
            animator.addAnimations {
                self.present(UINavigationController(rootViewController: controller ), animated: true)
            }
           
        }
    }
    
}

//MARK: - AddToDoItemDelegate

extension TasksListTableViewController: AddOrDeleteToDoItemDelegate {
    func addToDoItem(_ toDoItem: ToDoItem) {
        
        if let indexOfExistingToDo = allToDos.firstIndex(where: { $0.id == toDoItem.id }) {
            self.fileCache.addNewTask(task: toDoItem)
            self.allToDos.remove(at: indexOfExistingToDo)
            self.allToDos.insert(toDoItem, at: indexOfExistingToDo)
            tableView.reloadRows(at: [IndexPath(row: indexOfExistingToDo, section: 0)],
                                 with: .automatic)
            
        } else {
            let newIndex = IndexPath(row: allToDos.count, section: 0)
            self.fileCache.addNewTask(task: toDoItem)
            self.allToDos.append(toDoItem)
            tableView.insertRows(at: [newIndex],
                                 with: .automatic)
        }
        self.fileCache.saveAllTasks()
    }
    
    func deleteToDoItem(_ toDoItem: ToDoItem) {
        let index = allToDos.firstIndex { $0.id == toDoItem.id }
        self.fileCache.removeTaskWithId(id: toDoItem.id)
        self.allToDos.remove(at: index!)
        if toDoItem.isDone {
            self.doneToDos.removeAll { $0.id ==
                toDoItem.id }
        }
        tableView.deleteRows(at: [IndexPath(row: index!, section: 0)], with: .fade)
        self.header.doneCountlabel.text = "Сделано - \(self.doneToDos.count)"
        tableView.beginUpdates()
        tableView.endUpdates()
        self.fileCache.saveAllTasks()
    }
}

//MARK: - ContextMenuActions

extension TasksListTableViewController: ContextMenuActions {
     func makeDefaultMenu() -> UIMenu {
        // Create a UIAction for sharing
            let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { action in
                // Show system share sheet
            }
    
            // Create an action for renaming
            let rename = UIAction(title: "Rename", image: UIImage(systemName: "square.and.pencil")) { action in
                // Perform renaming
            }
    
            // Here we specify the "destructive" attribute to show that it’s destructive in nature
            let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive) { action in
                // Perform delete
            }
    
            // Create and return a UIMenu with all of the actions as children
            return UIMenu(title: "", children: [share, rename, delete])
    }
    
    
}


