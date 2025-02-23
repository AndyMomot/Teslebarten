//
//  ProfileViewModel.swift
//  Teslebarten
//
//  Created by Andrii Momot on 23.02.2025.
//

import UIKit.UIImage

extension ProfileView {
    final class ViewModel: ObservableObject {
        @Published var nickname = ""
        @Published var brandName = ""
        @Published var userImage = UIImage()
        @Published var brandImage = UIImage()
        
        @Published var showUserImagePicker = false
        @Published var showBrandImagePicker = false
        
        @Published var isNotificationsOn = false
        
        let privacyPolicyURL = URL(string: "https://www.google.com")
        let supportURL = URL(string: "https://www.google.com")
        let appStoreURL = URL(string: "https://apps.apple.com/app/id6740994248")
        
        @Published var showPrivacy = false
        @Published var showSupport = false
        @Published var showLogoutAlert = false
    }
}

extension ProfileView.ViewModel {
    func getUser() async {
        guard let user = DefaultsService.shared.user else { return }
        await MainActor.run { [weak self] in
            guard let self else { return }
            self.nickname = user.nickname
            self.brandName = user.brandName
        }
        
        if let imageData = await FileManagerService().fetchImage(with: user.id),
            let uiImage = UIImage(data: imageData) {
            await MainActor.run { [weak self] in
                guard let self else { return }
                self.userImage = uiImage
            }
        }
        
        let brandImageId = user.id + "brand"
        if let imageData = await FileManagerService().fetchImage(with: brandImageId),
            let uiImage = UIImage(data: imageData) {
            await MainActor.run { [weak self] in
                guard let self else { return }
                self.brandImage = uiImage
            }
        }
    }
    
    func updateUser(nickname: String) async {
        guard var user = DefaultsService.shared.user else { return }
        user.nickname = nickname
        DefaultsService.shared.user = user
    }
    
    func updateUser(brandName: String) async {
        guard var user = DefaultsService.shared.user else { return }
        user.brandName = brandName
        DefaultsService.shared.user = user
    }
    
    func updateUserImage(image: UIImage) async {
        guard let user = DefaultsService.shared.user else { return }
        
        if let userImageData = image.pngData() {
            await FileManagerService().saveImage(data: userImageData, for: user.id)
        }
    }
    
    func updateBrandImage(image: UIImage) async {
        guard let user = DefaultsService.shared.user else { return }
        if let brandImageData = image.pngData() {
            let id = user.id + "brand"
            await FileManagerService().saveImage(data: brandImageData, for: id)
        }
    }
    
    func removeData() async {
        DefaultsService.shared.removeAll()
        FileManagerService().removeAllFiles()
    }
}

// MARK: Notifications -
extension ProfileView.ViewModel {
    func onToggle() async {
        do {
            let granted = try await NotificationManager.shared.requestPermission()
            if !granted {
                NotificationManager.shared.openNotificationSettings()
            } else {
                await updateToggle()
            }
        } catch {
            NotificationManager.shared.openNotificationSettings()
        }
    }
    
    func updateToggle() async {
        let isGranted = await checkNotificationPermission()
        await MainActor.run { [weak self] in
            guard let self else { return }
            self.isNotificationsOn = isGranted
        }
    }
    
    func checkNotificationPermission() async -> Bool {
        let permission = await NotificationManager.shared.checkPermission()
        var isGranted: Bool {
            switch permission {
            case .authorized, .provisional:
                return true
            default:
                return false
            }
        }
        
        return isGranted
    }
}
