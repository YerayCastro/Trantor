//
//  LoginView.swift
//  Trantor
//
//  Created by Yery Castro on 30/11/23.
//

import SwiftUI

fileprivate struct LoginView: ViewModifier {
    @Binding var login: Bool
    
    @State var username = ""
    @State var password = ""
    
    @FocusState var focus: String?
    
    func body(content: Content) -> some View {
        content
        // Para la pantalla de login
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay {
            Rectangle()
                .fill(.ultraThinMaterial)
            // Si pulso en el botón de login aparece la pantalla.opacidad 1 muestra pantalla, opacidad 0 la oculta.
                .opacity(login ? 1.0 : 0.0)
            
            VStack {
                Text("Welcome to **Trantor**")
                    .font(.title)
                HStack {
                    Text("Username:")
                        .bold()
                        .frame(width: 100)
                    TextField("Enter the username", text: $username)
                        .textContentType(.username)
                        .autocorrectionDisabled()
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .focused($focus, equals: "username")
                }
                HStack {
                    Text("Password:")
                        .bold()
                        .frame(width: 100)
                    SecureField("Enter the password", text: $password)
                        .textContentType(.password)
                        .focused($focus, equals: "password")
                }
                Button {
                    focus = nil
                    login = false
                } label: {
                    Text("Login")
                }
                .padding(.top)
                .buttonStyle(.bordered)
                
                Button {
                    
                } label: {
                    Text("Lost password")
                }
                .font(.footnote)
                .bold()
            }
            .textFieldStyle(.roundedBorder)
            .padding()
            .background {
                Color(white: 0.9)
            }
            .padding()
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
            .opacity(login ? 1.0 : 0.0)
            .offset(y: login ? 0 : 300)
        }
        .animation(.default, value: login)
        .ignoresSafeArea()
    }
}

extension View {
    func loginView(login: Binding<Bool>) -> some View {
        modifier(LoginView(login: login))
    }
}
