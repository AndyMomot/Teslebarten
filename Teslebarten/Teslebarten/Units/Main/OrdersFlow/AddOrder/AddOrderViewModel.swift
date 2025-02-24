//
//  AddOrderViewModel.swift
//  Teslebarten
//
//  Created by Andrii Momot on 24.02.2025.
//

import Foundation

extension AddOrderView {
    final class ViewModel: ObservableObject {
        @Published var viewState: AddOrderView.ViewState = .add {
            didSet { Task { await setFields(for: viewState) }}
        }
        
        @Published var tables: [Table] = []
        
        @Published var selectedTable: Table? { didSet { validate() }}
        @Published var content = "" { didSet { validate() }}
        @Published var comment = "" { didSet { validate() }}
        @Published var status: Order.Status = .new
        
        @Published var isValidFields = false
    }
}

extension AddOrderView.ViewModel {
    func setFields(for state: AddOrderView.ViewState) async {
        switch state {
        case .add: break
        case .edit(let order):
            await MainActor.run { [weak self] in
                guard let self else { return }
                self.selectedTable = order.table
                self.content = order.content
                self.comment = order.comment
                self.status = order.status
            }
        }
    }
    
    func validate() {
        isValidFields = selectedTable != nil
        && !content.isEmpty
        && !comment.isEmpty
    }
    
    func getTables() async {
        let tables = DefaultsService.shared.tables
        await MainActor.run { [weak self] in
            self?.tables = tables
        }
    }
    
    func save() async {
        switch viewState {
        case .add:
            guard let selectedTable else { return }
            let order = Order(
                table: selectedTable,
                content: self.content,
                comment: self.comment,
                status: self.status
            )
            DefaultsService.shared.orders.append(order)
        case .edit(var order):
            let shared = DefaultsService.shared
            if let index = shared.orders.firstIndex(where: { $0.id == order.id }) {
                guard let selectedTable else { return }
                order.table = selectedTable
                order.content = content
                order.comment = comment
                order.status = status
                shared.orders[index] = order
            }
        }
    }
    
    func delete(order: Order) async {
        DefaultsService.shared.orders.removeAll(where: { $0.id == order.id })
    }
}

extension AddOrderView {
    enum ViewState {
        case add
        case edit(order: Order)
        
        var title: String {
            switch self {
            case .add:
                return "Añadir nuevo pedido"
            case .edit:
                return "Editar orden"
            }
        }
        
        var next: String {
            switch self {
            case .add:
                return "Agregar"
            case .edit:
                return "Borrar"
            }
        }
    }
}
