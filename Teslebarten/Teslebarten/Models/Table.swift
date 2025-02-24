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
    enum Status: Int, Codable, CaseIterable {
        case free = 0
        case reserved
        case taken
        
        var name: String {
            switch self {
            case .free:
                return "Gratis"
            case .reserved:
                return "Reservado"
            case .taken:
                return "Ocupado"
            }
        }
    }
}
