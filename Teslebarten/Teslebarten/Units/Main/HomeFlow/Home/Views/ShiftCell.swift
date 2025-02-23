//
//  ShiftCell.swift
//  Teslebarten
//
//  Created by Andrii Momot on 23.02.2025.
//

import SwiftUI

struct ShiftCell: View {
    let item: Shift
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.name)
                        .foregroundStyle(.appleRed)
                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 14))
                    
                    Text(item.position)
                        .foregroundStyle(.gray)
                        .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 12))
                }
                
                Spacer(minLength: 20)
                
                HStack(spacing: 4) {
                    Text(item.dateStart.toString(format: .ddMMYYHHmm))
                    Text("-")
                    Text(item.dateFinish.toString(format: .ddMMYYHHmm))
                }
                .foregroundStyle(.gray)
                .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 10))
            }
            HStack(spacing: .zero) {
                Rectangle()
                    .fill(.appleRed)
                Rectangle()
                    .fill(.appleRed.opacity(0.5))
            }
            .frame(height: 2)
        }
    }
}

#Preview {
    ShiftCell(item: .init(
        name: "Roberto",
        dateStart: .init(),
        dateFinish: .init().addOrSubtract(component: .hour, value: 9),
        position: "Security"))
    .padding()
}
