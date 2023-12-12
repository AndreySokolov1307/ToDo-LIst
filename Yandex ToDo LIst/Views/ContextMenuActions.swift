//
//  ContextMenuActions.swift
//  Yandex ToDo LIst
//
//  Created by Андрей Соколов on 15.10.2023.
//

import Foundation
import UIKit

protocol ContextMenuActions {
     func makeDefaultMenu() -> UIMenu 
}

//class contextMenuActions {
//    static func makeDefaultMenu() -> UIMenu {
//
//        // Create a UIAction for sharing
//        let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { action in
//            // Show system share sheet
//        }
//
//        // Create an action for renaming
//        let rename = UIAction(title: "Rename", image: UIImage(systemName: "square.and.pencil")) { action in
//            // Perform renaming
//        }
//
//        // Here we specify the "destructive" attribute to show that it’s destructive in nature
//        let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive) { action in
//            // Perform delete
//        }
//
//        // Create and return a UIMenu with all of the actions as children
//        return UIMenu(title: "", children: [share, rename, delete])
//    }
//}
