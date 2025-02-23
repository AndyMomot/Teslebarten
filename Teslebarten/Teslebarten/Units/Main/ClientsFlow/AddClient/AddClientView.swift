//
//  AddClientView.swift
//  Teslebarten
//
//  Created by Andrii Momot on 23.02.2025.
//

import SwiftUI

struct AddClientView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: ViewModel
    
    init(state: ViewState, viewModel: ViewModel = ViewModel()) {
        viewModel.viewState = state
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Asset.background.swiftUIImage
                .resizable()
                .ignoresSafeArea()
            Color.silver.opacity(0.85)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                BackButton(title: viewModel.viewState.title)
                    .padding(.horizontal)
                
                ScrollView {
                    VStack(spacing: 20) {
                        CustomTextField(title: "Nombre completo del cliente",
                                        placeholder: "Introduzca el nombre completo del cliente",
                                        text: $viewModel.fullName)
                        
                        CustomTextField(title: "Número de teléfono",
                                        placeholder: "00",
                                        text: $viewModel.phone,
                                        keyboardType: .phonePad)
                        
                        CustomTextField(title: "Historial de pedidos",
                                        placeholder: "Introduzca pedidos anteriores del cliente",
                                        text: $viewModel.ordersHistory)
                        
                        NextButton(title: viewModel.viewState.next) {
                            Task {
                                await viewModel.save()
                                dismiss.callAsFunction()
                            }
                        }
                        .disabled(!viewModel.isValidFields)
                        
                        switch viewModel.viewState {
                        case .add:
                            EmptyView()
                        case .edit(let client):
                            Button {
                                Task {
                                    await viewModel.delete(client: client)
                                    dismiss.callAsFunction()
                                }
                            } label: {
                                Text("Eliminar")
                                    .foregroundStyle(.appleRed)
                                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 16))
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, UIScreen.main.bounds.height * 0.08)
                }
            }
        }
        .hideKeyboardWhenTappedAround()
    }
}

#Preview {
    AddClientView(state: .add)
}

#Preview {
    AddClientView(state: .edit(client: .init(
        fullName: "Patricia Furtado",
        phone: "+34 50663000",
        ordersHistory: "Historial de pedidos: lana, paella, burrito"
    )))
}
