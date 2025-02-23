//
//  AddShiftView.swift
//  Teslebarten
//
//  Created by Andrii Momot on 23.02.2025.
//

import SwiftUI

struct AddShiftView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            Asset.background.swiftUIImage
                .resizable()
                .ignoresSafeArea()
            Color.silver.opacity(0.85)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                BackButton(title: "Agregar un nuevo turno")
                    .padding(.horizontal)
                
                ScrollView {
                    VStack(spacing: 20) {
                        CustomTextField(title: "Nombre completo del empleado",
                                        text: $viewModel.name)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Hora de cambio")
                                .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                                .foregroundStyle(.graphite)
                            
                            HStack {
                                VStack {
                                    DatePicker("Inicio del turno", selection: $viewModel.dateStart)
                                    
                                    DatePicker("Fin del turno", selection: $viewModel.dateFinish)
                                    
                                }
                                .tint(.appleRed)
                                .foregroundStyle(.graphite)
                                .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
                            }
                            .padding(.horizontal)
                            .padding(.vertical)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .overlay {
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(.graphite, lineWidth: 1)
                            }
                            .padding(1)
                        }
                        
                        CustomTextField(title: "Posición",
                                        text: $viewModel.position)
                        
                        NextButton(title: "Agregar") {
                            Task {
                                await viewModel.saveShift()
                                dismiss.callAsFunction()
                            }
                        }
                        .disabled(!viewModel.isValidFields)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, UIScreen.main.bounds.height * 0.08)
                }
            }
        }
    }
}

#Preview {
    AddShiftView()
}
