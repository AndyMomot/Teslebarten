//
//  StatisticsView.swift
//  Teslebarten
//
//  Created by Andrii Momot on 24.02.2025.
//

import SwiftUI

struct StatisticsView: View {
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
                    
                    Text("Finanzas")
                        .foregroundStyle(.graphite)
                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 18))
                        .padding(.horizontal)
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            StatisticChart(
                                selection: $viewModel.transactionType,
                                transactions: viewModel.transactions,
                                totalAmount: viewModel.totalAmount)
                            .onChange(of: viewModel.transactionType) { _ in
                                Task {
                                    await viewModel.getTransactions()
                                }
                            }
                            
                            ForEach(viewModel.transactions) { item in
                                NavigationLink {
                                    AddTransactionView(state: .edit(item: item))
                                } label: {
                                    TransactionCell(item: item)
                                }
                            }
                            .padding(.horizontal)
                        }
                        .padding(.bottom, UIScreen.main.bounds.height * 0.08)
                    }
                    .scrollIndicators(.never)
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            viewModel.showAddTransaction.toggle()
                        } label: {
                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30)
                                .foregroundStyle(.white)
                                .padding()
                                .background(.appleRed)
                                .clipShape(Circle())
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.bottom, UIScreen.main.bounds.height * 0.08)
                }
            }
            .onAppear {
                Task {
                    await viewModel.getTransactions()
                }
            }
            .navigationDestination(isPresented: $viewModel.showAddTransaction) {
                AddTransactionView(state: .add)
            }
        }
    }
}

#Preview {
    StatisticsView()
}
