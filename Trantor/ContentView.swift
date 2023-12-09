//
//  ContentView.swift
//  Trantor
//
//  Created by Yery Castro on 23/11/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    // Crear el modelContext
    @Environment(\.modelContext) var context
    // @Environtment NO propaga los Bindings.
    @Environment(TrantorVM.self) var vm
    // hay que poner la consulta para que la pantalla pueda redibujarse, al hacer la consulta.
    @Query var readedBooks: [BooksData]
    
    let item = GridItem(.adaptive(minimum: 150), alignment: .center)
    
    // Variable para la navegación por estados.
    @State var selected: Book?
    
    @Namespace private var namespace
    
    
    // Navegación con estados
    var body: some View {
        ZStack {
            mainScroll
            // En SwiftUI si algo tiene opacidad 0, NO está.
                .opacity(selected == nil ? 1.0 : 0.0)
            if selected != nil {
                BookDetail(selected: $selected, namespace: namespace)
            }
        }
        // Para la animación del botón.
        .animation(.default, value: selected)
    }
    
    var mainScroll: some View {
        // Para poder pasar el binding del VM.Es una copia de vm, pero por referencia.
        // @Bindable var bvm = vm
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [item]) {
                    ForEach(vm.books.books) { book in
                        if book != selected {
                            BookCoverView(book: book, namespace: namespace)
                                .onTapGesture {
                                    selected = book
                                }
                            // Crear contextMenu.Que marca los libros como leídos,o no leídos.
                                .contextMenu {
                                    Button {
                                        // Llamo a la función y le paso el contexto
                                        try? vm.toggleReaded(book: book, context: context)
                                    } label: {
                                        if readedBooks.contains(where: { $0.id == book.id }) {
                                            Label("Mark as unread", systemImage: "book")
                                        } else {
                                            Label("Mark as read", systemImage: "book")
                                        }
                                    }
                                }
                                .padding()
                        } else {
                            Rectangle()
                                .fill(.clear)
                                .frame(width: 150, height: 230)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Trantor Books")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        vm.login = true
                    } label: {
                        Image(systemName: "person.badge.shield.checkmark")
                            .font(.title)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView.preview
        .modelContainer(testModelContainer)
}


