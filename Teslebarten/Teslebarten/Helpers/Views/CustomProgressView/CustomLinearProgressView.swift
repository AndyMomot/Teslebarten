import SwiftUI

struct CustomLinearProgressView: View {
    let progress: CGFloat
    var backgroundColors: [Color] = [.gray]
    var progressColors: [Color] = [.blue]
    var height: CGFloat = 8
    var cornerRadius: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(LinearGradient(
                        colors: backgroundColors,
                        startPoint: .leading,
                        endPoint: .trailing
                    ))
                    .frame(width: geometry.size.width, height: height)
                
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(LinearGradient(
                        colors: progressColors,
                        startPoint: .leading,
                        endPoint: .trailing
                    ))
                    .frame(width: max(0, min((progress * geometry.size.width), geometry.size.width)),
                           height: height
                    )
            }
        }
        .frame(height: height)
    }
}

#Preview {
    ZStack {
        CustomLinearProgressView(progress: 1.0)
            .padding()
    }
}

