//
//  Client.swift
//  Teslebarten
//
//  Created by Andrii Momot on 23.02.2025.
//

import Foundation

struct Client: Identifiable, Codable {
    private(set) var id = UUID().uuidString
    var fullName: String
    var phone: String
    var ordersHistory: String
}
