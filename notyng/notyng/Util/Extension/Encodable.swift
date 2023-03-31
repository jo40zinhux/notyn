//
//  Encodable.swift
//  notyng
//
//  Created by João Pedro on 29/03/23.
//

import Foundation

extension Encodable {
    var dict : [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else { return nil }
        return json
    }
}
