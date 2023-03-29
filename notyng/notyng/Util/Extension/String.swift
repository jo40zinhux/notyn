//
//  String.swift
//  notyng
//
//  Created by João Pedro on 29/03/23.
//

import Foundation

extension String {
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        let date = dateFormatter.date(from: self)
        return date ?? Date()
    }
}
