//
//  Date.swift
//  notyng
//
//  Created by João Pedro on 20/03/23.
//

import Foundation

extension Date {
    func formattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
    
    func daysBetween(compare: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: self, to: compare).day ?? 0
    }
}
