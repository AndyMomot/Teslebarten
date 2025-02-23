//
//  ShiftDetails.swift
//  Teslebarten
//
//  Created by Andrii Momot on 23.02.2025.
//

import SwiftUI

struct ShiftDetails: View {
    let item: Shift
    var action: (ViewAction) -> Void
    
    var body: some View {
        ZStack {
            VStack {
                Button {
                    action(.dismiss)
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.graphite)
                            .padding(14)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                        Spacer()
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: .zero) {
                HStack {
                    Text(item.dateStart.toString(format: .dayOfWeekMonthDay))
                        .font(.largeTitle)
                    
                    Spacer()
                    
                    Button {
                        action(.delete(id: item.id))
                    } label: {
                        Image(systemName: "trash")
                    }
                }
                .foregroundStyle(.white)
                .padding()
                .background(.appleRed)
                
                VStack(alignment: .leading, spacing: 20) {
                    createRow(title: "Nombre completo del empleado:",
                              value: item.name)
                    
                    let timeStart = item.dateStart.toString(format: .HHMM)
                    let timeFinish = item.dateFinish.toString(format: .HHMM)
                    createRow(title: "Hora de cambio:",
                              value: "\(timeStart) - \(timeFinish)")
                    
                    createRow(title: "Posición:",
                              value: item.position)
                }
                .padding()
                .background(.white)
            }
            .padding(.horizontal, 40)
        }
        .background(.ultraThinMaterial)
    }
}

extension ShiftDetails {
    enum ViewAction {
        case dismiss
        case delete(id: String)
    }
}

private extension ShiftDetails {
    func createRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .foregroundStyle(.graphite)
                .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 14))
            Spacer()
            Text(value)
                .foregroundStyle(.graphite)
                .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
        }
    }
}

#Preview {
    ZStack {
        Color.red
        
        ShiftDetails(item: .init(
            name: "Roberto",
            dateStart: .init(),
            dateFinish: .init().addOrSubtract(component: .hour, value: 9),
            position: "Security")) {_ in}
    }
}
