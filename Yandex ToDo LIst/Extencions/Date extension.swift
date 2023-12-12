//
//  Date extension.swift
//  Yandex ToDo LIst
//
//  Created by admin on 22.09.2023.
//

import Foundation
import UIKit

extension Date {
    
    // Use to get ISO80601 formatted date from string
    static func date(from string: String) -> Date? {
        let formater = ISO8601DateFormatter()
        formater.timeZone = .current
        
        return formater.date(from: string)
    }
}
    
