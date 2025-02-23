import Foundation
import UserNotifications
import UIKit.UIApplication

final class NotificationManager {
    static let shared = NotificationManager()
    private let center = UNUserNotificationCenter.current()
    
    private init() {}
    
    func requestPermission() async throws -> Bool {
        if await checkPermission() != .notDetermined {
            return false
        }
        
        let granted: Bool = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Bool, Error>) in
            center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                continuation.resume(returning: granted)
            }
        }

        if granted {
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }

        return granted
    }
    
    func checkPermission() async -> UNAuthorizationStatus {
        await withCheckedContinuation { continuation in
            center.getNotificationSettings { settings in
                DispatchQueue.main.async {
                    continuation.resume(returning: settings.authorizationStatus)
                }
            }
        }
    }
    
    func openNotificationSettings() {
        center.getNotificationSettings { settings in
            DispatchQueue.main.async {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }
        }
    }
}
