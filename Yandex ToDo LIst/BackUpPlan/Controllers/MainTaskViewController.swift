//
//  TaskViewController.swift
//  Yandex ToDo LIst
//
//  Created by admin on 22.09.2023.
//

import UIKit

class MainTaskViewController: UIViewController {
    
    var myView: MainView {
        return view as! MainView
    }
    
    override func loadView() {
        self.view = MainView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "To Do"
        myView.insideTableView.delegate = self
        myView.insideTableView.dataSource = self
print("proverka")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(myView.insideTableView.frame.height)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(myView.insideTableView.frame.height)
        myView.setupTableViewHeight()

    }
        
    private func setupViews() {
        
    }
    
}

//MARK: - UITableViewDataSourse

extension MainTaskViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("rows")
       return  3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return myView.importanceCell
        case 1:
            return myView.deadlineCell
        case 2:
            return myView.datepickerCell
        default:
             fatalError()
        }
    }
    

}

//MARK: - UITableViewDelegate

extension MainTaskViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 2:
            return myView.datepickerCell.datePicker.frame.height + 12
        default:
            return 56
        }
    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//
//    }
}
