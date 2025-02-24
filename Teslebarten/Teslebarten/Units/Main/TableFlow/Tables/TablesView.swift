//
//  TablesView.swift
//  Teslebarten
//
//  Created by Andrii Momot on 24.02.2025.
//

import SwiftUI

struct TablesView: View {
    @StateObject private var viewModel = ViewModel()
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
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
                    
                    Text("Base de clientes")
                        .foregroundStyle(.graphite)
                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 18))
                        .padding(.horizontal)
                    
                    ScrollView {
                        VStack {
                            LazyVGrid(columns: columns, spacing: 10) {
                                ForEach(viewModel.tables.indices, id: \.self) { index in
                                    let table = viewModel.tables[index]
                                    NavigationLink {
                                        AddTableView(state: .edit(index: index + 1,
                                                                  table: table))
                                    } label: {
                                        TableCell(index: index + 1, table: table)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .scrollIndicators(.never)
                    
                    NextButton(title: "Agregar una nueva tabla") {
                        viewModel.showAddTable.toggle()
                    }
                    .padding(.horizontal)
                    .padding(.bottom, UIScreen.main.bounds.height * 0.08)
                }
            }
            .onAppear {
                Task {
                    await viewModel.getTables()
                }
            }
            .navigationDestination(isPresented: $viewModel.showAddTable) {
                AddTableView(state: .add)
            }
        }
    }
}

#Preview {
    TablesView()
}
