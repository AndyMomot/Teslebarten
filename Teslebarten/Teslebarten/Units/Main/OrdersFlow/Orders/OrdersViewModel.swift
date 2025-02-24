//
//  OrdersViewModel.swift
//  Teslebarten
//
//  Created by Andrii Momot on 24.02.2025.
//

import Foundation

extension OrdersView {
    final class ViewModel: ObservableObject {
        @Published var orders: [Order] = []
        @Published var status = Order.Status.new
        @Published var showAddOrder = false
    }
}

extension OrdersView.ViewModel {
    func getOrders() async {
        let orders = DefaultsService.shared.orders
        let sortedOrders = sortOrders(by: status, orders: orders)
        await MainActor.run { [weak self] in
            self?.orders = sortedOrders
        }
    }
}

private extension OrdersView.ViewModel {
    func sortOrders(by selectedStatus: Order.Status, orders: [Order]) -> [Order] {
        return orders.sorted {
            if $0.status == selectedStatus && $1.status != selectedStatus {
                return true
            } else if $0.status != selectedStatus && $1.status == selectedStatus {
                return false
            }
            return $0.status.rawValue < $1.status.rawValue
        }
    }
}
