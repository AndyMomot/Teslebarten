import SwiftUI

struct CustomTextField: View {
    var title: String
    var placeholder: String = ""
    var isDynamic = false
    var showPencil = false
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if !title.isEmpty {
                Text(title)
                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                    .foregroundStyle(.graphite)
            }
            
            if isDynamic {
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $text)
                        .scrollContentBackground(.hidden)
                        .foregroundStyle(.graphite)
                        .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 28)
                        .keyboardType(keyboardType)
                    
                    if text.isEmpty {
                        createPlaceholder(text: placeholder,
                                          isDynamic: isDynamic)
                    }
                }
                .background(.clear)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.graphite, lineWidth: 1)
                }
                .padding(1)
                
            } else {
                TextField(text: $text) {
                    createPlaceholder(text: placeholder,
                                      isDynamic: isDynamic)
                }
                .font(Fonts.SFProDisplay.regular.swiftUIFont(size: 16))
                .keyboardType(keyboardType)
                .foregroundStyle(.graphite)
                .padding(.horizontal, 30)
                .padding(.vertical)
                .background(.clear)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .overlay {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.graphite, lineWidth: 1)
                }
                .padding(1)
            }
        }
        .multilineTextAlignment(.leading)
        .hideKeyboardWhenTappedAround()
        .padding(.horizontal, 4)
    }
}

private extension CustomTextField {
    func createPlaceholder(text: String, isDynamic: Bool) -> some View {
        return Text(text)
            .font(Fonts.SFProDisplay.lightItalic.swiftUIFont(size: 16))
            .foregroundStyle(.graphite)
            .padding(.horizontal, isDynamic ? 16 : 0)
            .padding(.vertical, isDynamic ? 30 : 0)
            .allowsHitTesting(false)
    }
}

#Preview {
    ZStack {
        Color.white
        
        ScrollView {
            VStack(spacing: 20) {
                CustomTextField(title: "",
                                placeholder: "placeholder",
                                showPencil: true,
                                text: .constant("Some text"))
                
                CustomTextField(title: "Title",
                                placeholder: "placeholder",
                                isDynamic: true,
                                text: .constant(""))
                .frame(minHeight: 300)
            }
            .padding()
        }
    }
}
