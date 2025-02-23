//
//  ProfileView.swift
//  Teslebarten
//
//  Created by Andrii Momot on 23.02.2025.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var rootViewModel: RootContentView.ViewModel
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            Asset.background.swiftUIImage
                .resizable()
                .ignoresSafeArea()
            Color.silver.opacity(0.85)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                BackButton(title: "Perfil y configuración")
                    .padding(.horizontal)
                
                ScrollView {
                    VStack(spacing: 20) {
                        VStack(spacing: .zero) {
                            Button {
                                viewModel.showBrandImagePicker.toggle()
                            } label: {
                                Image(uiImage: viewModel.brandImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 160)
                                    .clipShape(Rectangle())
                                
                            }

                            VStack(spacing: 12) {
                                Button {
                                    viewModel.showUserImagePicker.toggle()
                                } label: {
                                    Image(uiImage: viewModel.userImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 160, height: 160)
                                        .clipShape(Circle())
                                        .overlay {
                                            Circle()
                                                .stroke(.white, lineWidth: 10)
                                        }
                                }
                                
                                TextField("Ingresa tu apodo", text: $viewModel.nickname)
                                    .foregroundStyle(.appleRed)
                                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 20))
                                    .onChange(of: viewModel.nickname) { newValue in
                                        Task {
                                            await viewModel.updateUser(nickname: newValue)
                                        }
                                    }
                                
                                TextField("Introduzca el nombre de su establecimiento", text: $viewModel.brandName)
                                    .foregroundStyle(.gray)
                                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                                    .onChange(of: viewModel.brandName) { newValue in
                                        Task {
                                            await viewModel.updateUser(brandName: newValue)
                                        }
                                    }
                            }
                            .multilineTextAlignment(.center)
                            .padding(.top, -80)
                            .padding(.horizontal)
                        }
                        
                        VStack(spacing: 16) {
                            HStack {
                                Text("Notificaciones")
                                    .foregroundStyle(.graphite)
                                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                                
                                Spacer()
                                
                                Toggle("", isOn: $viewModel.isNotificationsOn)
                                    .labelsHidden()
                                    .tint(.appleRed)
                                    .simultaneousGesture(
                                        TapGesture().onEnded {
                                            Task {
                                                await viewModel.onToggle()
                                            }
                                        }
                                    )
                            }
                            
                            ProfileButton(title: "Política de privacidad") {
                                viewModel.showPrivacy.toggle()
                            }
                            
                            ProfileButton(title: "Apoyo") {
                                viewModel.showSupport.toggle()
                            }
                            
                            ProfileButton(title: "Actualizar la aplicación") {
                                if let url = viewModel.appStoreURL {
                                    UIApplication.shared.open(url)
                                }
                            }
                            
                            ProfileButton(title: "Borrar datos y salir") {
                                viewModel.showLogoutAlert.toggle()
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.bottom, UIScreen.main.bounds.height * 0.08)
                }
                .scrollIndicators(.never)
            }
            
        }
        .onAppear {
            Task {
                await viewModel.getUser()
                await viewModel.updateToggle()
            }
        }
        .sheet(isPresented: $viewModel.showPrivacy) {
            SwiftUIViewWebView(url: viewModel.privacyPolicyURL)
        }
        .sheet(isPresented: $viewModel.showSupport) {
            SwiftUIViewWebView(url: viewModel.supportURL)
        }
        .sheet(isPresented: $viewModel.showUserImagePicker) {
            ImagePicker(selectedImage: $viewModel.userImage) { selection in
                Task {
                    await viewModel.updateUserImage(image: selection)
                }
            }
        }
        .sheet(isPresented: $viewModel.showBrandImagePicker) {
            ImagePicker(selectedImage: $viewModel.brandImage) { selection in
                Task {
                    await viewModel.updateBrandImage(image: selection)
                }
            }
        }
        .alert("Borrar datos y salir",
               isPresented: $viewModel.showLogoutAlert) {
            Button("Cancelar", role: .cancel) {}
            Button("Confirmar", role: .destructive) {
                Task {
                    await viewModel.removeData()
                    await MainActor.run {
                        rootViewModel.setFlow(.onboarding)
                    }
                }
            }
        } message: {
            Text("¿Está seguro de que desea cerrar la aplicación y eliminar todos los datos?")
        }
    }
}

#Preview {
    ProfileView()
}
