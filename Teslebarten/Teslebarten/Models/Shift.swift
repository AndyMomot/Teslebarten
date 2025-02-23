//
//  Shift.swift
//  Teslebarten
//
//  Created by Andrii Momot on 23.02.2025.
//

import Foundation

struct Shift: Codable, Identifiable {
    private(set) var id = UUID().uuidString
    var name: String
    var dateStart: Date
    var dateFinish: Date
    var position: String
}
