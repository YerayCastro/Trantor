//
//  TrantorMain.swift
//  Trantor
//
//  Created by Yery Castro on 27/11/23.
//

import SwiftUI

struct TrantorMain: View {
    @Environment(TrantorVM.self) var vm
    var body: some View {
        @Bindable var bvm = vm
        TabView {
            ContentView()
                .tabItem {
                    Label("Books", systemImage: "books.vertical")
                }
            ReadedBooks()
                .tabItem {
                    Label("Readed", systemImage: "book.closed")
                }
        }
        .loginView(login: $bvm.login)
    }
}

#Preview {
    TrantorMain.preview
}
