//
//  DefaultsService.swift
//
//  Created by Andrii Momot on 16.04.2024.
//

import Foundation

final class DefaultsService {
    static let shared = DefaultsService()
    private let standard = UserDefaults.standard
    private init() {}
}

extension DefaultsService {
    func removeAll() {
        if let bundleIdentifier = Bundle.main.bundleIdentifier {
            standard.removePersistentDomain(forName: bundleIdentifier)
        }
    }
    
    var flow: RootContentView.ViewState {
        get {
            let name = standard.string(forKey: Keys.flow.rawValue) ?? ""
            return RootContentView.ViewState(rawValue: name) ?? .onboarding
        }
        set {
            standard.set(newValue.rawValue, forKey: Keys.flow.rawValue)
        }
    }
}
 
extension DefaultsService {
    var user: User? {
        get {
            if let data = standard.data(forKey: Keys.user.rawValue),
               let user = try? JSONDecoder().decode(User.self, from: data) {
                return user
            }
            return nil
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                standard.set(data, forKey: Keys.user.rawValue)
            }
        }
    }
    
    var shifts: [Shift] {
        get {
            if let data = standard.data(forKey: Keys.shifts.rawValue),
               let items = try? JSONDecoder().decode([Shift].self, from: data) {
                return items
            }
            return []
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                standard.set(data, forKey: Keys.shifts.rawValue)
            }
        }
    }
    
    var clients: [Client] {
        get {
            if let data = standard.data(forKey: Keys.clients.rawValue),
               let items = try? JSONDecoder().decode([Client].self, from: data) {
                return items
            }
            return []
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                standard.set(data, forKey: Keys.clients.rawValue)
            }
        }
    }
    
    var tables: [Table] {
        get {
            if let data = standard.data(forKey: Keys.tables.rawValue),
               let items = try? JSONDecoder().decode([Table].self, from: data) {
                return items
            }
            return []
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                standard.set(data, forKey: Keys.tables.rawValue)
            }
        }
    }
    
    var orders: [Order] {
        get {
            if let data = standard.data(forKey: Keys.orders.rawValue),
               let items = try? JSONDecoder().decode([Order].self, from: data) {
                return items
            }
            return []
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                standard.set(data, forKey: Keys.orders.rawValue)
            }
        }
    }
    
    var transaction: [Transaction] {
        get {
            if let data = standard.data(forKey: Keys.transaction.rawValue),
               let items = try? JSONDecoder().decode([Transaction].self, from: data) {
                return items
            }
            return []
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                standard.set(data, forKey: Keys.transaction.rawValue)
            }
        }
    }
}

// MARK: - Keys
extension DefaultsService {
    enum Keys: String {
        case flow
        case user
        case shifts
        case clients
        case tables
        case orders
        case transaction
    }
}
