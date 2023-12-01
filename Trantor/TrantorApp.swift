//
//  TrantorApp.swift
//  Trantor
//
//  Created by Yery Castro on 23/11/23.
//

import SwiftUI
import SwiftData

@main
struct TrantorApp: App {
    // Inyectamos el TrantorVM() en toda la App
    @State var vm = TrantorVM()
    var body: some Scene {
        WindowGroup {
            AppStateView()
                .environment(vm)
            // Inyectamos la alerta aquí para que se propague por toda la aplicación.
                .alert("App Alert",
                       isPresented: $vm.showAlert) {
                } message: {
                    Text(vm.errorMsg)
                }
        }
        // Para crear el Contenedor. Ponemos el modelo(BooksData), hay que ponerlo con el .self. Para que aparezca la BD con datos cargados, ponemos el clousure después del modelContainer.
        .modelContainer(for: BooksData.self) { result in
            // Preguntamos si ha sido .succes, sino se sale.
            guard case .success(let container) = result else { return }
            let _ = container.mainContext
        }
    }
}
