//
//  SplashView.swift
//  Trantor
//
//  Created by Yery Castro on 29/11/23.
//

import SwiftUI

struct SplashView: View {
    @Environment(TrantorVM.self) var vm
    
    @State var loading = false
    @State var appear = false
    
    var body: some View {
        ZStack {
            Color.trantor
            Image(.trantorIcon)
            // Para que la imágen suba cuando arranque
                .offset(y: appear ? -150 : 0)
            // Vista de progreso
            ProgressView()
                .controlSize(.extraLarge)
                .tint(.white)
            // Cuando esté cargando se muestra, cuando no esté cargando no se muestra.
                .opacity(loading ? 1.0 : 0.0)
        }
        .ignoresSafeArea()
        
        .animation(.bouncy().speed(0.5), value: appear)
        // La animación dura dos segundos, para despues hacer la carga de los datos.
        .task {
            // Para que tarde un segundo en arrancar la app.
            try? await Task.sleep(for: .seconds(1))
            // Se pone el appear a tru, y hace la animación de subida de la imágen.
            appear = true
            // Tardará otro segundo.
            try? await Task.sleep(for: .seconds(2))
            // Se pone cargando a true.
            loading = true
            // Recupera los datos de la nube.
            await vm.getData()
            // Cuando termina de recuperar los datos, termina la pantalla de carga.
            loading = false
            // Cuando acaba, el estado pasa a .home y va a la pantalla de TrantorMain.
            vm.appState = .home
        }
    }
}

#Preview {
    SplashView()
        .environment(TrantorVM())
}
