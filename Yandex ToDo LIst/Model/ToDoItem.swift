//
//  File.swift
//  Yandex ToDo LIst
//
//  Created by admin on 16.09.2023.
//

import Foundation

struct ToDoItem: Equatable {

    var id: String
    let text: String
    let importanceRate: Importance
    let deadline: Date?
    let isDone: Bool
    let creationDate: Date
    let modificationDate: Date?
    
    init(id: String = UUID().uuidString,
         text: String,
         importanceRate: Importance,
         deadline: Date? = nil,
         isDone: Bool,
         creationDate: Date,
         modificationDate: Date? = nil) {
        
        self.id = id
        self.text = text
        self.importanceRate = importanceRate
        self.deadline = deadline
        self.isDone = isDone
        self.creationDate = creationDate
        self.modificationDate = modificationDate
    }
    
    enum Importance: String {
       case low, normal, hight
    }

}

//MARK: - Keys for json dictionary

fileprivate enum JsonKeys {
    static let id = "id"
    static let text = "text"
    static let importanceRate = "importance"
    static let isDone = "isDone"
    static let deadline = "deadline"
    static let creationDate = "creationDate"
    static let modificationDate = "modificationDate"
}

//MARK: - Json property and json parsing

extension ToDoItem {
    
    var json: Any {
        var dictionary: [String : Any] = [:]
        
        dictionary[JsonKeys.id] = id
        dictionary[JsonKeys.text] = text
        dictionary[JsonKeys.isDone] = isDone
        dictionary[JsonKeys.creationDate] = creationDate.ISO8601Format()
        
        if importanceRate != .normal {
            dictionary[JsonKeys.importanceRate] = importanceRate.rawValue
        }
        
        //TODO: - all dates -2 hours from kld time, fix if important
        if let deadline = deadline {
            dictionary[JsonKeys.deadline] = deadline.ISO8601Format()
        }
        
        if let modificationDate = modificationDate {
            dictionary[JsonKeys.modificationDate] = modificationDate.ISO8601Format()
        }
        
        return dictionary
    }
    
    static func parse(json: Any) -> ToDoItem? {
        guard let dictionary = json as? [String : Any] else { return nil }
        
        guard let id = dictionary[JsonKeys.id] as? String,
              let text = dictionary[JsonKeys.text] as? String,
              let isDone = dictionary[JsonKeys.isDone] as? Bool,
              let creationDate = (dictionary[JsonKeys.creationDate] as? String).flatMap(Date.date(from:))
        else { return nil }
        
        let importance = (dictionary[JsonKeys.importanceRate] as? String).flatMap(Importance.init(rawValue:)) ?? .normal
        let deadline = (dictionary[JsonKeys.deadline] as? String).flatMap(Date.date(from:))
        let modificationDate = (dictionary[JsonKeys.modificationDate] as? String).flatMap(Date.date(from:))
        
        let toDoItem = ToDoItem(id: id,
                                text: text,
                                importanceRate: importance,
                                deadline: deadline,
                                isDone: isDone,
                                creationDate: creationDate,
                                modificationDate: modificationDate)
        return toDoItem
    }
}


    

