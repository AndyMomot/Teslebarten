//
//  AddOrderView.swift
//  Teslebarten
//
//  Created by Andrii Momot on 24.02.2025.
//

import SwiftUI

struct AddOrderView: View {
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
                        Menu {
                            ForEach(viewModel.tables) { table in
                                Button {
                                    viewModel.selectedTable = table
                                } label: {
                                    Text("Plazas: \(table.count), estado: \(table.status.name)")
                                }

                            }
                        } label: {
                            CustomTextField(title: "Número de mesa",
                                            placeholder: "00",
                                            text:  .constant("\(viewModel.selectedTable?.count ?? 0)"))
                            .disabled(true)
                        }
                        
                        CustomTextField(title: "Orden",
                                        placeholder: "Ingresa tu pedido...",
                                        text: $viewModel.content)
                        
                        CustomTextField(title: "Comentario",
                                        placeholder: "Introduce un comentario...",
                                        text: $viewModel.comment)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Estado")
                                .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                                .foregroundStyle(.graphite)
                            
                            Picker("Estado", selection: $viewModel.status) {
                                ForEach(Order.Status.allCases, id: \.rawValue) { status in
                                    Text(status.name)
                                        .foregroundColor(.red)
                                        .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                                        .tag(status)
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
                        case .edit(let order):
                            Button {
                                Task {
                                    await viewModel.delete(order: order)
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
        .onAppear {
            Task {
                await viewModel.getTables()
            }
        }
    }
}

#Preview {
    AddOrderView(state: .add)
}

#Preview {
    AddOrderView(state: .edit(order: .init(
        table: .init(count: 3, status: .free),
        content: "Coffee",
        comment: "Extra milk",
        status: .inProgress
    )))
}
