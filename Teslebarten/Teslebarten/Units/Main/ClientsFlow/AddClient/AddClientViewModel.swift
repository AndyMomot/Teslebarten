import Foundation

extension AddClientView {
    final class ViewModel: ObservableObject {
        @Published var viewState: AddClientView.ViewState = .add {
            didSet { Task { await setFields(for: viewState) }}
        }
        @Published var fullName: String = "" { didSet { validate() }}
        @Published var phone: String = "" { didSet { validate() }}
        @Published var ordersHistory: String = "" { didSet { validate() }}
        
        @Published var isValidFields = false
    }
}

extension AddClientView.ViewModel {
    func setFields(for state: AddClientView.ViewState) async {
        switch state {
        case .add: break
        case .edit(let client):
            await MainActor.run { [weak self] in
                guard let self else { return }
                self.fullName = client.fullName
                self.phone = client.phone
                self.ordersHistory = client.ordersHistory
            }
        }
    }
    
    func validate() {
        isValidFields = !fullName.isEmpty
        && !phone.isEmpty
        && !ordersHistory.isEmpty
    }
    
    func save() async {
        switch viewState {
        case .add:
            let client = Client(
                fullName: self.fullName,
                phone: self.phone,
                ordersHistory: self.ordersHistory
            )
            DefaultsService.shared.clients.append(client)
            
        case .edit(var client):
            let shared = DefaultsService.shared
            if let index = shared.clients.firstIndex(where: { $0.id == client.id }) {
                client.fullName = self.fullName
                client.phone = self.phone
                client.ordersHistory = self.ordersHistory
                
                shared.clients[index] = client
            }
        }
    }
    
    func delete(client: Client) async {
        DefaultsService.shared.clients.removeAll(where: { $0.id == client.id })
    }
}

extension AddClientView {
    enum ViewState {
        case add
        case edit(client: Client)
        
        var title: String {
            switch self {
            case .add:
                return "Agregar cliente"
            case .edit:
                return "Editar cliente"
            }
        }
        
        var next: String {
            switch self {
            case .add:
                return "Agregar"
            case .edit:
                return "Ahorrar"
            }
        }
    }
}
