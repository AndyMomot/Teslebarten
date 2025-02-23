import SwiftUI

struct TabBar: View {
    @StateObject private var viewModel = ViewModel()
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $viewModel.selection) {
                HomeView()
                    .tag(TabBarSelectionView.home.rawValue)
                
                ClientsView()
                    .tag(TabBarSelectionView.clients.rawValue)
                
                Text("tables")
                    .tag(TabBarSelectionView.tables.rawValue)
                
                Text("orders")
                    .tag(TabBarSelectionView.orders.rawValue)
                    .environmentObject(viewModel)
                
                Text("statistics")
                    .tag(TabBarSelectionView.statistics.rawValue)
                    .environmentObject(viewModel)
            }
            
            if viewModel.isShowTabBar {
                TabBarCustomView(selectedItem: $viewModel.selection)
                    .frame(height: UIScreen.main.bounds.height * 0.09)
                    .padding([.horizontal, .bottom], 20)
            }
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    TabBar()
}
