//
//  AddTableView.swift
//  Teslebarten
//
//  Created by Andrii Momot on 24.02.2025.
//

import SwiftUI

struct AddTableView: View {
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
                
                ScrollView {
                    VStack(spacing: 20) {
                        CustomTextField(title: "Número de asientos",
                                        placeholder: "00",
                                        text: $viewModel.count,
                                        keyboardType: .numberPad)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Estado")
                                .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                                .foregroundStyle(.graphite)
                            
                            Picker("Estado", selection: $viewModel.status) {
                                ForEach(Table.Status.allCases, id: \.rawValue) { status in
                                    Text(status.name)
                                        .foregroundColor(.red)
                                        .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                                        .tag(status)
                                }
                            }
                            .pickerStyle(.segmented)
                            .padding(.horizontal, 10)
                        }
                        
                        NextButton(title: viewModel.viewState.next) {
                            Task {
                                await viewModel.save()
                                dismiss.callAsFunction()
                            }
                        }
                        .disabled((Int(viewModel.count) ?? .zero) <= .zero)
                        .padding(.top)
                        
                        switch viewModel.viewState {
                        case .add:
                            EmptyView()
                        case .edit(_, let table):
                            Button {
                                Task {
                                    await viewModel.remove(table: table)
                                    dismiss.callAsFunction()
                                }
                            } label: {
                                Text("Eliminar")
                                    .foregroundStyle(.appleRed)
                                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 16))
                            }
                        }
                    }
                    .padding(.bottom, UIScreen.main.bounds.height * 0.08)
                }
            }
            .padding(.horizontal)
        }
        .hideKeyboardWhenTappedAround()
    }
}

#Preview {
    AddTableView(state: .add)
}

#Preview {
    AddTableView(state: .edit(index: 1, table: .init(count: 4, status: .reserved)))
}
