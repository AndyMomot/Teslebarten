import SwiftUI

struct OnboardingView: View {
    var item: OnboardingView.OnboardingItem
    @Binding var currentPageIndex: Int
    
    @EnvironmentObject private var rootViewModel: RootContentView.ViewModel
    @StateObject private var viewModel = OnboardingViewModel()
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack(spacing: 60) {
                Image(item.image)
                    .resizable()
                    .clipped()
                
                VStack(spacing: 16) {
                    Text(item.title)
                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 32))
                    Text(item.text)
                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 14))
                }
                .multilineTextAlignment(.center)
                .foregroundStyle(.graphite)
                .minimumScaleFactor(0.5)
                .padding(.horizontal)
                .lineSpacing(2)
                
                Spacer()
                
                if item.rawValue == item.lastIndex {
                    VStack(spacing: 10) {
                        NextButton(title: "Comenzar") {
                            viewModel.showLogin.toggle()
                        }
                        
                        Button {
                            viewModel.showPrivacy.toggle()
                        } label: {
                            Text("Al seleccionar “Iniciar” estoy de  acuerdo con ")
                                .foregroundColor(.graphite)
                            +
                            Text("Política de privacidad")
                                .foregroundColor(.appleRed)
                        }
                        .multilineTextAlignment(.center)
                        .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 14))
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.horizontal)
                }
                
                HStack {
                    Text("Próxima")
                        .foregroundStyle(.appleRed)
                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 14))
                        .hidden()
                    
                    Spacer()
                    
                    HStack(spacing: 14) {
                        ForEach(0...item.lastIndex, id: \.self) { index in
                            let isCurrent = index == currentPageIndex
                            if isCurrent {
                                Circle()
                                    .fill(.appleRed)
                                    .frame(width: 12)
                            } else {
                                Circle()
                                    .stroke(.appleRed, lineWidth: 1)
                                    .frame(width: 12)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        withAnimation {
                            currentPageIndex = item.lastIndex
                        }
                    } label: {
                        Text("Próxima")
                            .foregroundStyle(.appleRed)
                            .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 14))
                    }
                }
                .padding(.horizontal)
            }
        }
        .sheet(isPresented: $viewModel.showPrivacy) {
            SwiftUIViewWebView(url: viewModel.privacyPolicyURL)
        }
        .fullScreenCover(isPresented: $viewModel.showLogin) {
            LoginView()
        }
    }
}

#Preview {
    OnboardingView(item: .third, currentPageIndex: .constant(2))
}
