//
//  Table.swift
//  Teslebarten
//
//  Created by Andrii Momot on 24.02.2025.
//

import Foundation

struct Table: Identifiable, Codable {
    private(set) var id = UUID().uuidString
    var count: Int
    var status = Status.free
}

extension Table {
    enum Status: Codable {
        case free
        case reserved
        case taken
    }
}
