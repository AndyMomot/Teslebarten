//
//  ProfileButton.swift
//  Teslebarten
//
//  Created by Andrii Momot on 23.02.2025.
//

import SwiftUI

struct ProfileButton: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Text(title)
                Spacer()
                Image(systemName: "chevron.right")
            }
            .foregroundStyle(.graphite)
            .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
            .padding(.vertical, 4)
        }
    }
}

#Preview {
    ProfileButton(title: "Notificaciones") {}
        .padding()
}
