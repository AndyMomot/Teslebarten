//
//  CustomNavigationView.swift
//  Teslebarten
//
//  Created by Andrii Momot on 23.02.2025.
//

import SwiftUI

struct CustomNavigationView: View {
    @State private var brandImage: Image?
    @State private var brandName: String?
    
    var body: some View {
        HStack(spacing: 10) {
            if let brandImage {
                brandImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 40)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
            }
            
            Spacer()
            
            if let brandName {
                Text(brandName)
                    .foregroundStyle(.white)
                    .font(Fonts.SFProDisplay.semibold.swiftUIFont(size: 14))
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            
            if let brandImage {
                brandImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 40)
                    .hidden()
            }
        }
        .padding(12)
        .background(.appleRed)
        .onAppear {
            Task {
                await getUser()
            }
        }
    }
}

private extension CustomNavigationView {
    func getUser() async {
        guard let user = DefaultsService.shared.user else { return }
        await MainActor.run {
            self.brandName = user.brandName
        }
        
        let id = user.id + "brand"
        if let imageData = await FileManagerService().fetchImage(with: id),
            let uiImage = UIImage(data: imageData) {
            await MainActor.run {
                self.brandImage = Image(uiImage: uiImage)
            }
        }
    }
}

#Preview {
    CustomNavigationView()
}
