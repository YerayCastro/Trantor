//
//  ReadedBooks.swift
//  Trantor
//
//  Created by Yery Castro on 27/11/23.
//

import SwiftUI
import SwiftData

struct ReadedBooks: View {
    @Environment(\.modelContext) var context
    // Realizo una consulta ordenada con una animación
    @Query(sort: \BooksData.title, animation: .default) var readedBooks: [BooksData]
    var body: some View {
        List {
            ForEach(readedBooks) { book in
                VStack(alignment: .leading){
                    Text(book.title)
                        .font(.headline)
                    Text(book.author?.name ?? "")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                // Para borrar un libro
                .swipeActions {
                    Button(role: .destructive) {
                        deleteReaded(book: book)
                    } label: {
                        Label("Remove Reader", systemImage: "book.closed")
                    }
                }
            }
        }
    }
    
    func deleteReaded(book: BooksData) {
        context.delete(book)
    }
}


#Preview {
    ReadedBooks()
        .modelContainer(testModelContainer)
}
