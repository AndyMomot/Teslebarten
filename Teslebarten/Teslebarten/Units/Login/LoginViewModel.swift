//
//  LoginViewModel.swift
//  Teslebarten
//
//  Created by Andrii Momot on 22.02.2025.
//

import UIKit

extension LoginView {
    final class ViewModel: ObservableObject {
        @Published var userImage = UIImage() { didSet { validate() }}
        @Published var nickname = "" { didSet { validate() }}
        @Published var brandName = "" { didSet { validate() }}
        @Published var brandImage = UIImage() { didSet { validate() }}
        
        @Published var showUserImagePicker = false
        @Published var showBrandImagePicker = false
        @Published var isValidFields = false
    }
}

extension LoginView.ViewModel {
    func validate() {
        isValidFields = userImage != UIImage()
        && !nickname.isEmpty
        && !brandName.isEmpty
        && brandImage != UIImage()
    }
    
    func saveUser() async {
        let user = User(nickname: nickname, brandName: brandName)
        DefaultsService.shared.user = user
        
        if let userImageData = userImage.pngData() {
            await FileManagerService().saveImage(data: userImageData, for: user.id)
        }
        
        if let brandImageData = brandImage.pngData() {
            let id = user.id + "brand"
            await FileManagerService().saveImage(data: brandImageData, for: id)
        }
    }
}
