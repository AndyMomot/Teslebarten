//
//  AddTransactionView.swift
//  Teslebarten
//
//  Created by Andrii Momot on 24.02.2025.
//

import SwiftUI

struct AddTransactionView: View {
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
                        CustomTextField(title: "Nombre",
                                        placeholder: "...",
                                        text: $viewModel.name)
                        
                        CustomTextField(title: "Suma",
                                        placeholder: "00",
                                        text: $viewModel.amount,
                                        keyboardType: .numberPad)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Tipo")
                                .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                                .foregroundStyle(.graphite)
                            
                            Picker("Estado", selection: $viewModel.type) {
                                ForEach(Transaction.TransactionType.allCases, id: \.rawValue) { type in
                                    Text(type.name)
                                        .tag(type)
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                        .padding(.horizontal, 10)
                        
                        NextButton(title: viewModel.viewState.next) {
                            Task {
                                await viewModel.save()
                                dismiss.callAsFunction()
                            }
                        }
                        .disabled(!viewModel.isValidFields)
                        .padding(.top)
                        
                        switch viewModel.viewState {
                        case .add:
                            EmptyView()
                        case .edit(let item):
                            Button {
                                Task {
                                    await viewModel.delete(item: item)
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
    AddTransactionView(state: .add)
}

#Preview {
    AddTransactionView(state: .edit(item: .init(name: "Item 1", amount: 100, type: .income)))
}
