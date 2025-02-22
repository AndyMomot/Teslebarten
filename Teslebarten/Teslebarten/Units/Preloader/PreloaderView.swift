//
//  PreloaderView.swift
//  Libarorent
//
//  Created by Andrii Momot on 06.10.2024.
//

import SwiftUI

struct PreloaderView: View {
    
    var onDidLoad: () -> Void
    
    @State private var timer: Timer?
    @State private var progress: Double = 0.0
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Asset.preloader.swiftUIImage
                .resizable()
                .ignoresSafeArea()
            
            CustomLinearProgressView(
                progress: progress,
                backgroundColors: [.silver],
                progressColors: [.appleRed.opacity(0.2), .appleRed],
                height: 22,
                cornerRadius: 40
            )
            .padding(2)
            .overlay {
                RoundedRectangle(cornerRadius: 40)
                    .stroke(.appleRed, lineWidth: 2)
            }
                .padding(.horizontal)
                .padding(.top, bounds.height * 0.3)
        }
        .onAppear {
            startTimer()
        }
    }
}

private extension PreloaderView {
    func startTimer() {
        stopTimer()
        
        timer = .scheduledTimer(withTimeInterval: 0.01,
                                repeats: true, block: { timer in
            updateProgress(value: 0.005)
        })
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func updateProgress(value: Double) {
        let newProgress = progress + value
        
        DispatchQueue.main.async {
            withAnimation {
                progress = newProgress
            }
            
            if progress >= 1 {
                stopTimer()
                onDidLoad()
            }
        }
    }
}

#Preview {
    PreloaderView {}
}
