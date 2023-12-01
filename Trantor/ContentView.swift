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
    
    
    // Navegación con estados
    var body: some View {
        ZStack {
            mainScroll
            // En SwiftUI si algo tiene opacidad 0, NO está.
                .opacity(selected == nil ? 1.0 : 0.0)
            if selected != nil {
                BookDetail(selected: $selected)
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
                        AsyncImage(url: book.cover) { cover in
                            BookCoverView(cover: cover, book: book)
                        } placeholder: {
                            BookPlaceholder(book: book)
                        }
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
                                    Label("Mark as read", systemImage: "book.fill")
                                }
                            }
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
        .environment(TrantorVM.preview)
        .modelContainer(testModelContainer)
}
