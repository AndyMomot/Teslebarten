//
//  StatisticsViewModel.swift
//  Teslebarten
//
//  Created by Andrii Momot on 24.02.2025.
//

import Foundation

extension StatisticsView {
    final class ViewModel: ObservableObject {
        @Published var transactionType: Transaction.TransactionType = .income
        @Published var transactions: [Transaction] = []
        @Published var totalAmount: Int = .zero
        @Published var showAddTransaction = false
    }
}

extension StatisticsView.ViewModel {
    func getTransactions() async {
        let transactions = DefaultsService.shared.transaction.filter { $0.type == transactionType }
        let totalAmount = transactions.map { $0.amount }.reduce(0) {$0 + $1}
        await MainActor.run { [weak self] in
            self?.transactions = transactions
            self?.totalAmount = totalAmount
        }
    }
}
