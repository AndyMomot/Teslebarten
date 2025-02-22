//
//  LoginView.swift
//  Teslebarten
//
//  Created by Andrii Momot on 22.02.2025.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var rootViewModel: RootContentView.ViewModel
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 50) {
                    Text("Antes de empezar a trabajar, es necesario familiarizarse")
                        .foregroundStyle(.graphite)
                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 20))
                    
                    VStack(alignment: .leading, spacing: 20) {
                        CustomTextField(
                            title: "Apodo",
                            placeholder: "Ingresa tu apodo",
                            text: $viewModel.nickname
                        )
                        
                        CustomTextField(
                            title: "Nombre de su institución",
                            placeholder: "Introduzca el nombre de su establecimiento",
                            text: $viewModel.brandName
                        )
                        
                        HStack(spacing: 20) {
                            Button {
                                viewModel.showImagePicker.toggle()
                            } label: {
                                if viewModel.image == UIImage() {
                                    Image(systemName: "photo.badge.plus")
                                        .resizable()
                                        .scaledToFill()
                                        .foregroundStyle(.appleRed)
                                        .frame(width: 34, height: 34)
                                        .padding()
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(.graphite, lineWidth: 1)
                                        }
                                        .padding(1)
                                } else {
                                    Image(uiImage: viewModel.image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 70, height: 70)
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                }
                            }
                            
                            Text("Añadir un logotipo")
                                .foregroundStyle(.graphite)
                                .font(Fonts.SFProDisplay.lightItalic.swiftUIFont(size: 16))
                            Spacer()
                        }
                    }
                    
                    NextButton(title: "Acceso") {
                        Task {
                            await viewModel.saveUser()
                            await MainActor.run {
                                rootViewModel.setFlow(.main)
                            }
                        }
                    }
                    .disabled(!viewModel.isValidFields)
                    
                    HStack {
                        Spacer()
                        Asset.logo.swiftUIImage
                            .resizable()
                            .scaledToFit()
                            .padding(.horizontal, 100)
                        Spacer()
                    }
                }
                .padding(.horizontal)
            }
            .scrollIndicators(.never)
        }
        .sheet(isPresented: $viewModel.showImagePicker) {
            ImagePicker(selectedImage: $viewModel.image)
        }
    }
}

#Preview {
    LoginView()
}
