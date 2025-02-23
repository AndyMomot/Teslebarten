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
                        Button {
                            viewModel.showUserImagePicker.toggle()
                        } label: {
                            HStack(spacing: 20) {
                                if viewModel.userImage == UIImage() {
                                    imagePickerPlaceholder
                                } else {
                                    selectedImage(uiImage: viewModel.userImage)
                                }
                                
                                Text("Añade tu foto")
                                    .foregroundStyle(.graphite)
                                    .font(Fonts.SFProDisplay.lightItalic.swiftUIFont(size: 16))
                                Spacer()
                            }
                        }
                        
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
                        
                        Button {
                            viewModel.showBrandImagePicker.toggle()
                        } label: {
                            HStack(spacing: 20) {
                                if viewModel.brandImage == UIImage() {
                                    imagePickerPlaceholder
                                } else {
                                    selectedImage(uiImage: viewModel.brandImage)
                                }
                                
                                Text("Añadir un logotipo")
                                    .foregroundStyle(.graphite)
                                    .font(Fonts.SFProDisplay.lightItalic.swiftUIFont(size: 16))
                                Spacer()
                            }
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
        .sheet(isPresented: $viewModel.showUserImagePicker) {
            ImagePicker(selectedImage: $viewModel.userImage)
        }
        .sheet(isPresented: $viewModel.showBrandImagePicker) {
            ImagePicker(selectedImage: $viewModel.brandImage)
        }
    }
}

private extension LoginView {
    func selectedImage(uiImage: UIImage) -> some View {
        Image(uiImage: uiImage)
            .resizable()
            .scaledToFill()
            .frame(width: 70, height: 70)
            .clipShape(RoundedRectangle(cornerRadius: 15))
    }
    
    var imagePickerPlaceholder: some View {
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
    }
}

#Preview {
    LoginView()
}
