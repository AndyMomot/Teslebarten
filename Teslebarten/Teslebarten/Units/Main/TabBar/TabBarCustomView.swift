import SwiftUI

struct TabBarCustomView: View {
    @Binding var selectedItem: Int
    
    private let items: [TabBar.Item] = [
        .init(imageName: Asset.tab1.name),
        .init(imageName: Asset.tab2.name),
        .init(imageName: Asset.tab3.name),
        .init(imageName: Asset.tab4.name),
        .init(imageName: Asset.tab5.name)
    ]
    
    private var arrange: [Int] {
        Array(0..<items.count)
    }
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            ForEach(0..<items.count, id: \.self) { index in
                let item = items[index]
                let isSelected = selectedItem == index
                
                Button {
                    DispatchQueue.main.async {
                        withAnimation {
                            selectedItem = index
                        }
                    }
                } label: {
                    VStack(spacing: 0) {
                        Circle()
                            .fill(.white)
                            .frame(width: 30)
                            .overlay {
                                Circle()
                                    .fill(.appleRed)
                                    .frame(width: 10)
                            }
                            .offset(y: -15)
                            .hidden(!isSelected)
                        
                        Image(item.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40)
                    }
                }
                .buttonStyle(PlainButtonStyle())
                
                Spacer()
            }
        }
        .padding(.horizontal)
        .padding(.bottom)
        .background(.appleRed)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    ZStack {
        Color.gray
        VStack {
            Spacer()
            TabBarCustomView(selectedItem: .constant(0))
                .padding()
        }
    }
}
