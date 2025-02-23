//
//  ClientsView.swift
//  Teslebarten
//
//  Created by Andrii Momot on 23.02.2025.
//

import SwiftUI

struct ClientsView: View {
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
                    
                    HStack(spacing: 8) {
                        Image(systemName: "magnifyingglass")
                        TextField("Search", text: $viewModel.query)
                            .foregroundStyle(.graphite)
                            .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
                            .onChange(of: viewModel.query) { newValue in
                                Task {
                                    await viewModel.getClients()
                                }
                            }
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 14)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                    .overlay {
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(.graphite, lineWidth: 1)
                    }
                    .padding(.horizontal)
                    
                    Text("Base de clientes")
                        .foregroundStyle(.graphite)
                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 18))
                        .padding(.horizontal)
                    
                    ScrollView {
                        VStack(spacing: 15) {
                            ForEach(viewModel.clients) { client in
                                NavigationLink {
                                    AddClientView(state: .edit(client: client))
                                } label: {
                                    ClientCell(client: client)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .scrollIndicators(.never)
                    
                    NextButton(title: "Agregar cliente") {
                        viewModel.showAddClient.toggle()
                    }
                    .padding(.horizontal)
                    .padding(.bottom, UIScreen.main.bounds.height * 0.08)
                }
            }
            .onAppear {
                Task {
                    await viewModel.getClients()
                }
            }
            .navigationDestination(isPresented: $viewModel.showAddClient) {
                AddClientView(state: .add)
            }
        }
    }
}

#Preview {
    ClientsView()
}
