//
//  DateFormatterRU.swift
//  VK_application
//
//  Created by Сергей Чумовских  on 27.10.2021.
//

import Foundation

class DateFormatterRU {
    
    func ShowMeDate(date: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy HH:mm"
        let date = Date(timeIntervalSince1970: TimeInterval(date))
        let stringDate = dateFormatter.string(from: date)
        return stringDate
    }
}
