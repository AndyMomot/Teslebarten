//
//  NavigationBarTitle.swift
//  BoFitvada
//
//  Created by Andrii Momot on 11.02.2025.
//

import SwiftUI

struct NavigationBarTitle: View {
    var text: String
    
    var body: some View {
        HStack {
            Text(text)
                .foregroundStyle(.darkPurple)
                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 28))
            Spacer()
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    NavigationBarTitle(text: "SETTINGS")
        .background(.red)
}
