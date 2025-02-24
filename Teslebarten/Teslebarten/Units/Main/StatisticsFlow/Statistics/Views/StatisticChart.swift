//
//  StatisticChart.swift
//  Teslebarten
//
//  Created by Andrii Momot on 24.02.2025.
//

import SwiftUI
import Charts

struct StatisticChart: View {
    @Binding var selection: Transaction.TransactionType
    let transactions: [Transaction]
    let totalAmount: Int
    
    var body: some View {
        VStack(spacing: 15) {
            Picker("", selection: $selection) {
                ForEach(Transaction.TransactionType.allCases, id: \.rawValue) { type in
                    Text(type.name)
                        .foregroundColor(.red)
                        .tag(type)
                        
                }
            }
            .pickerStyle(.segmented)
            .padding(.top, 20)
            .padding(.horizontal, 80)
            
            Text("\(totalAmount)")
                .foregroundStyle(.appleRed)
                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 24))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Chart {
                ForEach(transactions) { item in
                    AreaMark(x: .value("1", item.name),
                             y: .value("2", item.amount))
                    .foregroundStyle(.appleRed)
                }
            }
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 48))
    }
}

#Preview {
    ZStack {
        Color.gray
        ScrollView {
            StatisticChart(
                selection: .constant(.income),
                transactions: [
                    .init(name: "Item 1", amount: 100, type: .income),
                    .init(name: "Item 2", amount: 110, type: .income),
                    .init(name: "Item 3", amount: 90, type: .income),
                    .init(name: "Item 4", amount: 80, type: .income),
                    .init(name: "Item 5", amount: 150, type: .income),
                    .init(name: "Item 6", amount: 140, type: .income),
                    .init(name: "Item 7", amount: 120, type: .income),
                    .init(name: "Item 8", amount: 110, type: .income),
                ], totalAmount: 132132)
            .padding(.vertical)
        }
    }
}
