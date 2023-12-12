//
//  FileCash.swift
//  Yandex ToDo LIst
//
//  Created by admin on 17.09.2023.
//

import Foundation

class FileCache {
    
    private(set) var toDoItems: [ToDoItem] = []
     
    func addNewTask(task: ToDoItem) {
        if !toDoItems.contains(where: { $0.id == task.id }) {
            toDoItems.append(task)
        } else {
            if let index = toDoItems.firstIndex(where: { $0.id == task.id }) {
                toDoItems.remove(at: index)
                toDoItems.insert(task, at: index)
            }
        }
    }
    
    func removeTaskWithId(id: String) {
        toDoItems.removeAll { $0.id == id }
    }
    
    func saveAllTasks(to file: String = "tasks") {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory,
                                                          in: .userDomainMask).first!
        let archieveURL = documentsDirectory.appendingPathComponent(file).appendingPathExtension("json")
    
        let jsonArray = toDoItems.map { $0.json }
        
        guard let data = try? JSONSerialization.data(withJSONObject: jsonArray, options: [])
        else { print("Could not recieve data form json object"); return }
        
        do {
            try data.write(to: archieveURL)
        } catch {
            print("Couldnot write data to file")
        }
       
    }
    
    func loadAllTasks(from file: String = "tasks") {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory,
                                                          in: .userDomainMask).first!
        let archieveURL = documentsDirectory.appendingPathComponent(file).appendingPathExtension("json")
        
        guard let retrievedJsonData = try? Data(contentsOf: archieveURL)
        else {print("Could not retrieve json data"); return}
        
        guard let jsonObject = try? JSONSerialization.jsonObject(with: retrievedJsonData,
                                                                 options: []) as? [Any]
        else {print("Could not recieve json object"); return}
        
        toDoItems = jsonObject.compactMap(ToDoItem.parse)
    }
}

