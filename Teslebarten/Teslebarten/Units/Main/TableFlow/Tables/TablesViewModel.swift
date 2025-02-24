//
//  TablesViewModel.swift
//  Teslebarten
//
//  Created by Andrii Momot on 24.02.2025.
//

import Foundation

extension TablesView {
    final class ViewModel: ObservableObject {
        @Published var tables: [Table] = []
        @Published var showAddTable = false
    }
}

extension TablesView.ViewModel {
    func getTables() async {
        let tables = DefaultsService.shared.tables
        await MainActor.run { [weak self] in
            self?.tables = tables
        }
    }
}
