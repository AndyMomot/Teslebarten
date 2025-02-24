//
//  Order.swift
//  Teslebarten
//
//  Created by Andrii Momot on 24.02.2025.
//

import Foundation

struct Order: Identifiable, Codable {
    private(set) var id = UUID().uuidString
    var table: Table
    var content, comment: String
    var status: Status
}

extension Order {
    enum Status: Int, Codable, CaseIterable {
        case new = 1
        case inProgress
        case completed
        
        var name: String {
            switch self {
            case .new:
                return "Nuevo"
            case .inProgress:
                return "En curso"
            case .completed:
                return "Completado"
            }
        }
        
        var icon: String {
            switch self {
            case .new:
                return Asset.newOrder.name
            case .inProgress:
                return Asset.inProgressOrder.name
            case .completed:
                return Asset.completedOrder.name
            }
        }
    }
}
