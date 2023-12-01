//
//  AppStateView.swift
//  Trantor
//
//  Created by Yery Castro on 30/11/23.
//

import SwiftUI

struct AppStateView: View {
    @Environment(TrantorVM.self) var vm
    // Instancia de NetworkStatus. Se crea aquí porque esta pantalla está por encima de todas.(Pantalla de inicio).
    @State var networkStatus = NetworkStatus()
    @State var lastState: AppState = .splash
    
    var body: some View {
        Group {
            switch vm.appState {
            case .splash:
                SplashView()
            case .home:
                TrantorMain()
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            case .noInternet:
                NoConnectionView()
                    .transition(.opacity)
            }
        }
        .animation(.easeIn, value: vm.appState)
        // Al cambio de networkStatus reacione y cambia el estado.
        .onChange(of: networkStatus.status == .offline) {
            // Si networkStatus es igual a .offline, me cambias el estado a noInternet
            if networkStatus.status == .offline {
                // Para saber el estado anterior
                lastState = vm.appState
                vm.appState = .noInternet
            } else {
                // Si tiene internet pone el estado anterior.
                vm.appState = lastState
            }
        }
    }
}

#Preview {
    AppStateView()
        .environment(TrantorVM())
}
