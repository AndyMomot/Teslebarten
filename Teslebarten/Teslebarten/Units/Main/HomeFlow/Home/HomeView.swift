//
//  HomeView.swift
//  Teslebarten
//
//  Created by Andrii Momot on 23.02.2025.
//

import SwiftUI

struct HomeView: View {
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
                        .onTapGesture {
                            viewModel.showProfile.toggle()
                        }
                    
                    Text("Horario de turnos")
                        .foregroundStyle(.graphite)
                        .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 18))
                        .padding(.horizontal)
                    
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(viewModel.shifts) { shift in
                                Button {
                                    viewModel.shiftToShow = shift
                                    withAnimation {
                                        viewModel.showShiftDetails = true
                                    }
                                } label: {
                                    ShiftCell(item: shift)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .scrollIndicators(.never)
                    
                    NextButton(title: "Agregar un nuevo turno") {
                        viewModel.showAddShift.toggle()
                    }
                    .padding(.horizontal)
                    .padding(.bottom, UIScreen.main.bounds.height * 0.08)
                }
                
                if viewModel.showShiftDetails {
                    if let shiftToShow = viewModel.shiftToShow {
                        ShiftDetails(item: shiftToShow) { action in
                            Task {
                                await viewModel.handleShiftDetails(action: action)
                            }
                        }
                    }
                }
            }
            .onAppear {
                Task {
                    await viewModel.getShifts()
                }
            }
            .navigationDestination(isPresented: $viewModel.showProfile) {
                ProfileView()
            }
            .navigationDestination(isPresented: $viewModel.showAddShift) {
                AddShiftView()
            }
        }
    }
}

#Preview {
    HomeView()
}
