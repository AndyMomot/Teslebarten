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
                
                TablesView()
                    .tag(TabBarSelectionView.tables.rawValue)
                
                OrdersView()
                    .tag(TabBarSelectionView.orders.rawValue)
                    .environmentObject(viewModel)
                
                StatisticsView()
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
