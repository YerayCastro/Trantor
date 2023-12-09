//
//  StateMachines.swift
//  Trantor
//
//  Created by Yery Castro on 29/11/23.
//

import SwiftUI

/*:
 Enumeración para controlar los distintos estados que va a tener la aplicación.
 */

enum AppState {
    case splash
    case home
    case noInternet
}

// Para poder captura el valor en el scroll.
struct ScrollOffset: PreferenceKey {
    typealias Value = CGFloat
    
    static var defaultValue: CGFloat = 0.0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
