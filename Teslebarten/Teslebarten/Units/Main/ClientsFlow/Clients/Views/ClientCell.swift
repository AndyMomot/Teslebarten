//
//  ClientCell.swift
//  Teslebarten
//
//  Created by Andrii Momot on 23.02.2025.
//

import SwiftUI

struct ClientCell: View {
    var client: Client
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 20) {
                Asset.client.swiftUIImage
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(client.fullName)
                        .foregroundStyle(.appleRed)
                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 16))
                    
                    Text(client.phone)
                        .foregroundStyle(.gray)
                        .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 12))
                }
                
                Spacer()
                
                Text(client.ordersHistory)
                    .foregroundStyle(.gray)
                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 10))
                    .multilineTextAlignment(.trailing)
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
    ClientCell(client: .init(
        fullName: "Patricia Furtado",
        phone: "+34 50663000",
        ordersHistory: "Historial de pedidos: lana, paella, burrito"
    ))
    .padding()
}
