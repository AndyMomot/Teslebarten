//
//  OnboardingViewModel.swift
//  Goobeltoin
//
//  Created by Andrii Momot on 12.06.2024.
//

import Foundation

extension OnboardingView {
    final class OnboardingViewModel: ObservableObject {
        let privacyPolicyURL = URL(string: "https://www.google.com")
        @Published var showPrivacy = false
        @Published var showLogin = false
    }
    
    enum OnboardingItem: Int, CaseIterable {
        case first = 0
        case second
        case third
        
        var image: String {
            switch self {
            case .first:
                return Asset.onboard1.name
            case .second:
                return Asset.onboard2.name
            case .third:
                return Asset.onboard3.name
            }
        }
        
        var title: String {
            switch self {
            case .first:
                return "Organización de turnos"
            case .second:
                return "Base de datos de clientes"
            case .third:
                return "Comunicación interna"
            }
        }
        
        var text: String {
            switch self {
            case .first:
                return "Con nuestro aplicativo, los dueños de bares pueden gestionar fácilmente los turnos de los camareros. La planificación de cambios se realiza de manera intuitiva, asegurando que siempre haya el personal adecuado en el momento adecuado."
            case .second:
                return "Mantén un registro detallado de tus clientes y sus preferencias. Con esta función, podrás personalizar el servicio y mejorar la experiencia en cada visita."
            case .third:
                return "Las notificaciones sobre pedidos y la mensajería interna hacen que la comunicación entre el personal sea rápida y eficiente. Todos los miembros del equipo están siempre al tanto de cualquier cambio o solicitud en tiempo real."
            }
        }
        
        var nextButtonTitle: String {
            switch self {
            case .first, .second:
                return "Comenzar"
            case .third:
                return "START!"
            }
        }

        var next: Self {
            switch self {
            case .first:
                return .second
            case .second, .third:
                return .third
            }
        }
        
        var lastIndex: Int {
            OnboardingItem.allCases.last?.rawValue ?? .zero
        }
    }
}
