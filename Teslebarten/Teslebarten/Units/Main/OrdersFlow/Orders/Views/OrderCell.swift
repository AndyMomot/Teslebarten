//
//  OrderCell.swift
//  Teslebarten
//
//  Created by Andrii Momot on 24.02.2025.
//

import SwiftUI

struct OrderCell: View {
    let order: Order
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 20) {
                RoundedRectangle(cornerRadius: 6)
                    .fill(.appleRed)
                    .frame(width: 52, height: 54)
                    .overlay {
                        HStack(spacing: 3) {
                            Asset.person.swiftUIImage
                            Text("\(order.table.count)")
                                .foregroundStyle(.graphite)
                                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 10))
                        }
                    }
                
                VStack(alignment: .leading) {
                    Text(order.comment)
                        .foregroundStyle(.appleRed)
                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 14))
                    
                    Text(order.comment)
                        .foregroundStyle(.graphite)
                        .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 10))
                }
                
                Spacer()
                
                Image(order.status.icon)
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
    ZStack {
        Color.green
        
        VStack {
            OrderCell(order: .init(
                table: .init(count: 1, status: .free),
                content: "Coffee",
                comment: "Extra milk",
                status: .new
            ))
            
            OrderCell(order: .init(
                table: .init(count: 2, status: .reserved),
                content: "Coffee",
                comment: "Extra milk",
                status: .inProgress
            ))
            
            OrderCell(order: .init(
                table: .init(count: 3, status: .taken),
                content: "Coffee",
                comment: "Extra milk",
                status: .completed
            ))
        }
        .padding()
    }
}
