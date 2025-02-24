//
//  AddTransactionViewModel.swift
//  Teslebarten
//
//  Created by Andrii Momot on 24.02.2025.
//

import Foundation

extension AddTransactionView {
    final class ViewModel: ObservableObject {
        @Published var viewState: AddTransactionView.ViewState = .add {
            didSet { Task { await setFields(for: viewState) }}
        }
        
        @Published var name = "" { didSet { validate() }}
        @Published var amount = "" { didSet { validate() }}
        @Published var type: Transaction.TransactionType = .income
        
        @Published var isValidFields = false
    }
}

extension AddTransactionView.ViewModel {
    func setFields(for state: AddTransactionView.ViewState) async {
        switch state {
        case .add: break
        case .edit(let item):
            await MainActor.run { [weak self] in
                guard let self else { return }
                self.name = item.name
                self.amount = "\(item.amount)"
                self.type = item.type
            }
        }
    }
    
    func validate() {
        isValidFields = !name.isEmpty
        && Int(amount) ?? .zero > .zero
    }
    
    func save() async {
        switch viewState {
        case .add:
            let transaction = Transaction(
                name: name,
                amount: Int(amount) ?? .zero,
                type: type
            )
            DefaultsService.shared.transaction.append(transaction)
        case .edit(var item):
            let shared = DefaultsService.shared
            if let index = shared.transaction.firstIndex(where: { $0.id == item.id }) {
                item.name = name
                item.amount = Int(amount) ?? .zero
                item.type = type
                shared.transaction[index] = item
            }
        }
    }
    
    func delete(item: Transaction) async {
        DefaultsService.shared.transaction.removeAll(where: { $0.id == item.id })
    }
}

extension AddTransactionView {
    enum ViewState {
        case add
        case edit(item: Transaction)
        
        var title: String {
            return "Transacción"
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
