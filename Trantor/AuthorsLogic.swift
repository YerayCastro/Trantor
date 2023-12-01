//
//  AuthorsLogic.swift
//  Trantor
//
//  Created by Yery Castro on 27/11/23.
//

import SwiftUI

// Aquí sólo va la lógica

@Observable
final class AuthorsLogic {

    var authors: [Author] = []
    
    // Función que recibe un UUID, y devuelve un String opcional
    func getAuthors(id: UUID) -> String? {
        authors.first(where: { $0.id == id })?.name
    }
}
