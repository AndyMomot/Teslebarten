//
//  Transaction.swift
//  Teslebarten
//
//  Created by Andrii Momot on 24.02.2025.
//

import Foundation

struct Transaction: Identifiable, Codable {
    private(set) var id = UUID().uuidString
    var name: String
    var amount: Int
    var type: TransactionType
}

extension Transaction {
    enum TransactionType: Int, Codable, CaseIterable {
        case income = 0
        case cost
        
        var name: String {
            switch self {
            case .income:
                return "Ganancia"
            case .cost:
                return "Costos"
            }
        }
    }
}
