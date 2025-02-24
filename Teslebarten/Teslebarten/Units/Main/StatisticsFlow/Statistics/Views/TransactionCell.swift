//
//  TransactionCell.swift
//  Teslebarten
//
//  Created by Andrii Momot on 24.02.2025.
//

import SwiftUI

struct TransactionCell: View {
    let item: Transaction
    
    var body: some View {
        VStack {
            HStack(spacing: 12) {
                Asset.transaction.swiftUIImage
                
                Text(item.name)
                    .foregroundStyle(.appleRed)
                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 14))
                
                Spacer()
                
                Text("\(item.amount)")
                    .foregroundStyle(.graphite)
                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 14))
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
    TransactionCell(item: .init(name: "Item 1", amount: 100, type: .income))
        .padding()
}
