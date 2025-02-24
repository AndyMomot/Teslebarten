//
//  TableCell.swift
//  Teslebarten
//
//  Created by Andrii Momot on 24.02.2025.
//

import SwiftUI

struct TableCell: View {
    let index: Int
    let table: Table
    
    var body: some View {
        var backgroundColor: Color {
            switch table.status {
            case .free:
                return .white
            case .reserved:
                return .gray
            case .taken:
                return .appleRed
            }
        }
        
        var titleColor: Color {
            switch table.status {
            case .free:
                return .graphite
            case .reserved, .taken:
                return .white
            }
        }
        
        return HStack(alignment: .bottom, spacing: .zero) {
            personCountView
                .hidden()
            
            VStack(spacing: 6) {
                Text(table.status.name)
                    .foregroundStyle(titleColor)
                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 8))
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                
                Text("\(index)")
                    .foregroundStyle(.graphite)
                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 18))
                    .multilineTextAlignment(.center)
                
                Asset.table.swiftUIImage
                    .resizable()
                    .scaledToFit()
            }
            
            personCountView
        }
        .padding(10)
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

private extension TableCell {
    var personCountView: some View {
        HStack(spacing: 3) {
            Asset.person.swiftUIImage
            Text("\(table.count)")
                .foregroundStyle(.graphite)
                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 10))
        }
    }
}

#Preview {
    ZStack {
        Color.green
        
        HStack {
            TableCell(index: 1, table: .init(count: 2))
            
            TableCell(index: 1, table: .init(count: 2, status: .reserved))
            
            TableCell(index: 1, table: .init(count: 2, status: .taken))
        }
        .padding()
    }
}
