//
//  AddShiftViewModel.swift
//  Teslebarten
//
//  Created by Andrii Momot on 23.02.2025.
//

import Foundation

extension AddShiftView {
    final class ViewModel: ObservableObject {
        @Published var name = "" { didSet { validate() } }
        @Published var dateStart = Date() { didSet { validate() } }
        @Published var dateFinish = Date().addOrSubtract(component: .hour, value: 8) { didSet { validate() } }
        @Published var position = "" { didSet { validate() } }
        
        @Published var isValidFields = false
    }
}

extension AddShiftView.ViewModel {
    func validate() {
        isValidFields = !name.isEmpty
        && dateStart > .init()
        && dateFinish > dateStart
        && !position.isEmpty
    }
    
    func saveShift() async {
        let shift = Shift(
            name: self.name,
            dateStart: self.dateStart,
            dateFinish: self.dateFinish,
            position: self.position
        )
        
        DefaultsService.shared.shifts.append(shift)
    }
}
