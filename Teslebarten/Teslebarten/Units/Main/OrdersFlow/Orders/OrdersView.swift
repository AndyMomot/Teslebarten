//
//  OrdersView.swift
//  Teslebarten
//
//  Created by Andrii Momot on 24.02.2025.
//

import SwiftUI

struct OrdersView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.red
                    .ignoresSafeArea()
                Asset.background.swiftUIImage
                    .resizable()
                    .ignoresSafeArea(edges: [.horizontal, .bottom])
                Color.silver.opacity(0.85)
                    .ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 20) {
                    CustomNavigationView()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Notificación de pedido")
                            .foregroundStyle(.graphite)
                            .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 18))
                            .padding(.horizontal)
                        
                        Picker("Estado", selection: $viewModel.status) {
                            ForEach(Order.Status.allCases, id: \.rawValue) { status in
                                Text(status.name)
                                    .foregroundColor(.red)
                                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                                    .tag(status)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding(.horizontal, 10)
                        .onChange(of: viewModel.status) { _ in
                            Task { await viewModel.getOrders() }
                        }
                    }
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            ForEach(viewModel.orders) { order in
                                NavigationLink {
                                    AddOrderView(state: .edit(order: order))
                                } label: {
                                    OrderCell(order: order)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .scrollIndicators(.never)
                    
                    NextButton(title: "Añadir nuevo pedido") {
                        viewModel.showAddOrder.toggle()
                    }
                    .padding(.horizontal)
                    .padding(.bottom, UIScreen.main.bounds.height * 0.08)
                }
            }
            .onAppear {
                Task { await viewModel.getOrders() }
            }
            .navigationDestination(isPresented: $viewModel.showAddOrder) {
                AddOrderView(state: .add)
            }
        }
    }
}

#Preview {
    OrdersView()
}
