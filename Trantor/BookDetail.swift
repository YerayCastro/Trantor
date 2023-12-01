//
//  BookDetail.swift
//  Trantor
//
//  Created by Yery Castro on 29/11/23.
//

import SwiftUI

struct BookDetail: View {
    @Environment(TrantorVM.self) private var vm
    
    private var book: Book!
    @Binding var selected: Book?
    
    @State private var loaded = false
    
    init(selected: Binding<Book?>) {
        _selected = selected
        if let book = selected.wrappedValue {
            self.book = book
        }
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ScrollView {
                LazyVStack {
                    AsyncImage(url: book.cover) { cover in
                        BookCoverView(cover: cover, book: book, big: true)
                    } placeholder: {
                        BookPlaceholder(book: book)
                    }
                    Text(book.title)
                        .font(.title)
                        .bold()
                    if let author = vm.authors.getAuthors(id: book.author) {
                        Text(author)
                    }
                    if let plot = book.plot {
                        VStack(alignment: .leading) {
                            Text("Plot")
                                .bold()
                            Text(plot)
                                .font(.caption)
                        }
                        .padding(.vertical)
                    }
                    if let summary = book.summary {
                        VStack(alignment: .leading) {
                            Text("Summary")
                                .bold()
                            Text(summary)
                                .font(.caption)
                        }
                        .padding(.bottom)
                    }
                    VStack(alignment: .leading) {
                        HStack {
                            if book.price > 0 {
                                Text("**Price:** \(book.price.formatted(.currency(code: "usd")))")
                            }
                            Spacer()
                            if let pages = book.pages {
                                Text("**Pages:** \(pages)")
                            }
                        }
                    }
                }
                .padding(.horizontal)
                
            }
            
            Button {
                // Cambiamos el estado de selected y sale de la pantalla de detalle.
                selected = nil
            } label: {
                Image(systemName: "xmark")
                    .symbolVariant(.circle)
                    .symbolVariant(.fill)
                    .font(.largeTitle)
            }
            .padding(.trailing)
            .buttonStyle(.plain)
            .opacity(0.5)
            // Para ocultar el botón.
            // Cuando aparezca la pantalla y loaded sea igual a false, coloque el elemento en 100, cuando selected no sea nil, pone el elemento en 0.
            .offset(x: !loaded ? 100 : selected != nil ? 0 : 100)
        }
        // Pongo la animación por defecto, con el valor del cambio de loaded.
        .animation(.default, value: loaded)
        // Cuando aparece, es igual a true.El Botón aparece.
        .onAppear {
            loaded = true
        }
    }
}

#Preview {
    BookDetail(selected: .constant(.test))
        .environment(TrantorVM.preview)
}
