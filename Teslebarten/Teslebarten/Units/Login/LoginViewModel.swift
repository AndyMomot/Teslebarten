//
//  LoginViewModel.swift
//  Teslebarten
//
//  Created by Andrii Momot on 22.02.2025.
//

import UIKit

extension LoginView {
    final class ViewModel: ObservableObject {
        @Published var nickname = "" { didSet { validate() }}
        @Published var brandName = "" { didSet { validate() }}
        @Published var image = UIImage() { didSet { validate() }}
        
        @Published var showImagePicker = false
        @Published var isValidFields = false
    }
}

extension LoginView.ViewModel {
    func validate() {
        isValidFields = !nickname.isEmpty
        && !brandName.isEmpty
        && image != UIImage()
    }
    
    func saveUser() async {
        let user = User(nickname: nickname, brandName: brandName)
        DefaultsService.shared.user = user
        
        if let imageData = image.pngData() {
            await FileManagerService().saveImage(data: imageData, for: user.id)
        }
    }
}
