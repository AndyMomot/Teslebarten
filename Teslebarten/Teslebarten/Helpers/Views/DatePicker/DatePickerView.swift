//
//  DatePickerView.swift
//  Netflenaunt
//
//  Created by Andrii Momot on 14.01.2025.
//

import SwiftUI

struct DatePickerView: View {
    let title: String
    @Binding var selection: Date
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .foregroundStyle(.white)
                .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                .lineLimit(1)
                .minimumScaleFactor(0.7)
            
            HStack {
                DatePicker("", selection: $selection,
                           displayedComponents: .date)
                    .labelsHidden()
                    .colorScheme(.dark)
                    .accentColor(.blue)
                
                Spacer()
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 28)
            .background()
            .cornerRadius(8, corners: .allCorners)
            .shadowModifier()
        }
    }
}

#Preview {
    ZStack {
        DatePickerView(title: "Date", selection: .constant(.init()))
            .padding()
    }
}
