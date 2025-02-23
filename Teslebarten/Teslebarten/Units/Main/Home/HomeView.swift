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
        ZStack {
            Color.red
                .ignoresSafeArea()
            Asset.background.swiftUIImage
                .resizable()
                .ignoresSafeArea(edges: [.horizontal, .bottom])
            Color.silver.opacity(0.85)
                .ignoresSafeArea()
            
            VStack {
                CustomNavigationView()
                
                ScrollView {
                    VStack {
                        
                    }
                }
                .scrollIndicators(.never)
            }
        }
    }
}

#Preview {
    HomeView()
}
