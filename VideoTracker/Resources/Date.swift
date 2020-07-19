//
//  Date.swift
//  VideoTracker
//
//  Created by Кирилл Худяков on 18.07.2020.
//  Copyright © 2020 Татьяна Севостьянова. All rights reserved.
//

import Foundation


extension Date {
    static func dateComponentFrom(second: Double) -> DateComponents {
        let interval = TimeInterval(second)
        let date1 = Date()
        let date2 = Date(timeInterval: interval, since: date1)
        let calendar = NSCalendar.current
        
        var components = calendar.dateComponents([.year,.month,.day,.hour,.minute,.second,.weekday], from: date1, to: date2)
        components.calendar = calendar
        return components
    }
}

extension Date {
    var string: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru")
        formatter.dateFormat = "d MMM y"
        return formatter.string(from: self)
    }
}


extension Int {
    var string: String {
        return "\(self)"
    }
}
