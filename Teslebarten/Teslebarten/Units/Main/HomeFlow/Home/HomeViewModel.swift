//
//  HomeViewModel.swift
//  Teslebarten
//
//  Created by Andrii Momot on 23.02.2025.
//

import Foundation

extension HomeView {
    final class ViewModel: ObservableObject {
        @Published var showProfile = false
        @Published var showAddShift = false
        @Published var shifts: [Shift] = []
        @Published var shiftToShow: Shift?
        @Published var showShiftDetails = false
    }
}

extension HomeView.ViewModel {
    func getShifts() async {
        let shifts = DefaultsService.shared.shifts.sorted(by: { $0.dateStart < $1.dateStart })
        await MainActor.run { [weak self] in
            self?.shifts = shifts
        }
    }
    
    func handleShiftDetails(action: ShiftDetails.ViewAction) async {
        switch action {
        case .dismiss:
            await MainActor.run { [weak self] in
                self?.showShiftDetails = false
            }
        case .delete(let id):
            DefaultsService.shared.shifts.removeAll(where: { $0.id == id})
            await getShifts()
            
            await MainActor.run { [weak self] in
                self?.showShiftDetails = false
            }
        }
    }
}
