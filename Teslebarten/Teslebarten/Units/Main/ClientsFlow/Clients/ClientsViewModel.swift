//
//  ClientsViewModel.swift
//  Teslebarten
//
//  Created by Andrii Momot on 23.02.2025.
//

import Foundation

extension ClientsView {
    final class ViewModel: ObservableObject {
        @Published var query = ""
        @Published var clients: [Client] = []
        @Published var showAddClient = false
    }
}

extension ClientsView.ViewModel {
    func getClients() async {
        let clients = DefaultsService.shared.clients
        
        if query.isEmpty {
            await MainActor.run { [weak self] in
                self?.clients = clients
            }
        } else {
            let filteredClients = clients.filter { client in
                client.fullName.localizedCaseInsensitiveContains(query) ||
                client.phone.localizedCaseInsensitiveContains(query)
            }
            
            await MainActor.run { [weak self] in
                self?.clients = filteredClients
            }
        }
    }
}
