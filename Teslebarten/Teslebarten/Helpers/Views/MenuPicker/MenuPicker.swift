//
//  MenuPicker.swift
//  Golovytri
//
//  Created by Andrii Momot on 25.12.2024.
//

import SwiftUI

struct MenuPicker: View {
    let title: String
    let items: [String]
    var showAddButton = false
    @Binding var selection: String
    
    var onAdd: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text(title)
                    .foregroundStyle(.white)
                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                
                Spacer()
                
                if showAddButton {
                    Button {
                        onAdd?()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(.gray)
                            .fontWeight(.medium)
                            .padding(4)
                    }
                    
                }
            }
            
            Menu {
                ForEach(items, id: \.self) { item in
                    Button {
                        selection = item
                    } label: {
                        Text(item)
                    }
                }
            } label: {
                HStack {
                    if items.isEmpty {
                        Text("Pusty")
                            .foregroundStyle(.gray)
                            .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                        
                        Spacer()
                        
                    } else {
                        Text(selection.isEmpty ? "Wybierać" : selection)
                            .foregroundStyle(.gray)
                            .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                        
                        Spacer()
                        
                        Image(systemName: "chevron.down")
                            .foregroundStyle(.gray)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 28)
                .background()
                .cornerRadius(8, corners: .allCorners)
                .shadowModifier()
            }
        }
    }
}

#Preview {
    ZStack {
        VStack {
            MenuPicker(
                title: "Title",
                items: [
                    "Item 1", "Item 2", "Item 3"
                ],
                selection: .constant(""))
            
            MenuPicker(
                title: "Title",
                items: [],
                showAddButton: true,
                selection: .constant("")) {
                    
                }
        }
        .padding()
    }
}
