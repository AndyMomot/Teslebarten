//
//  AddTableViewModel.swift
//  Teslebarten
//
//  Created by Andrii Momot on 24.02.2025.
//

import Foundation

extension AddTableView {
    final class ViewModel: ObservableObject {
        @Published var viewState: AddTableView.ViewState = .add {
            didSet { Task { await setFields(for: viewState) }}
        }
        @Published var count = ""
        @Published var status: Table.Status = .free
    }
}

extension AddTableView.ViewModel {
    func setFields(for state: AddTableView.ViewState) async {
        switch state {
        case .add: break
        case .edit(_, let table):
            await MainActor.run { [weak self] in
                guard let self else { return }
                self.count = "\(table.count)"
                self.status = table.status
            }
        }
    }
    
    func save() async {
        switch viewState {
        case .add:
            let table = Table(count: Int(count) ?? .zero, status: status)
            DefaultsService.shared.tables.append(table)
            
        case .edit(_, var table):
            let shared = DefaultsService.shared
            if let index = shared.tables.firstIndex(where: { $0.id == table.id }) {
                table.count = Int(count) ?? .zero
                table.status = status
                shared.tables[index] = table
            }
        }
    }
    
    func remove(table: Table) async {
        DefaultsService.shared.tables.removeAll(where: { $0.id == table.id })
    }
}

extension AddTableView {
    enum ViewState {
        case add
        case edit(index: Int, table: Table)
        
        var title: String {
            switch self {
            case .add:
                return "Agregar una nueva tabla"
            case .edit(let index, _):
                return "Tabla número \(index)"
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
