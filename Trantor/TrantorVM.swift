//
//  TrantorVM.swift
//  Trantor
//
//  Created by Yery Castro on 27/11/23.
//

import SwiftUI
import SwiftData

@Observable
final class TrantorVM {
    let interactor: DataInteractor
    
    // Variable que controla los estados de la aplicación, viene del enum AppState. Cuando se arranca la aplicación está en la pantalla de splash.
    var appState: AppState = .splash
    
    // Inyectamos aquí el BooksLogic() y el AthorsLogic()
    let books = BooksLogic()
    let authors = AuthorsLogic()
    
    var showAlert = false
    var errorMsg = ""
    
    // Variable para acceder a pantalla de login
    var login = false
    
    // Con ObservationIgnored la variable no tendría repercusión en el cambio de la pantalla.
    @ObservationIgnored var ignored = 20
    
    init(interactor: DataInteractor = Network.shared) {
        self.interactor = interactor
        
    }
    // Función para recuperar los datos conjuntos de libros y autores
    func getData() async {
        do {
            let (books, authors) = try await (interactor.getBooks(), interactor.getAuthors())
            await MainActor.run {
                self.books.books = books
                self.authors.authors = authors
            }
        } catch {
            await MainActor.run {
                self.errorMsg = "\(error)"
                self.showAlert.toggle()
            }
        }
    }
    
    // Función para poder recuperar el autor y el libro. Recibe el libro y el contexto.
    func toggleReaded(book: Book, context: ModelContext) throws {
        // Primero pregunto por el autor
        guard let name = authors.getAuthors(id: book.author) else { return }
        // Primero buscar el libro,Creo una consulta.(FetchDescriptor)
        var query = FetchDescriptor<BooksData>()
        // Tengo que sacar la propiedad id, porque Swift data no puede acceder a la propiedad de una instancia.
        let bookID = book.id
        // Para recuperar un número fijo de valores(en este caso, sólo 1)
        query.fetchLimit = 1
        // Para recuperar la id del libro
        query.predicate = #Predicate { $0.id == bookID }
        // Ejecuto la query.Devuelve un array de BooksData.Quiero que devuelva el primer registro
        if let bookFound = try context.fetch(query).first {
            // Si existe el libro lo borro
            context.delete(bookFound)
        } else {
            // Si no existe lo creo. Hago la consulta de si existe el autor.
            var queryAuthor = FetchDescriptor<AuthorData>()
            // Tengo que sacar la propiedad author, porque Swift data no puede acceder a la propiedad de una instancia.
            let authorID = book.author
            // Recupero el autor.
            queryAuthor.predicate = #Predicate { $0.id == authorID }
            // Pregunto si existe el autor. si existe recupero el primer registro.
            if let authorFound = try context.fetch(queryAuthor).first {
                // Inserto el libro
                let bookDB = BooksData(book: book)
                bookDB.author = authorFound
                context.insert(bookDB)
            } else {
                // Si no existe tengo que crearlo
                let authorDB = AuthorData(id: book.author, name: name)
                let bookDB = BooksData(book: book, author: authorDB)
                context.insert(bookDB)
            }
        }
    }
    // Función para ver si un libro está leído.
    func isBookReaded(book: Book, context: ModelContext) -> Bool {
        var query = FetchDescriptor<BooksData>()
        let bookID = book.id
        query.predicate = #Predicate { $0.id == bookID }
        return (try? context.fetchCount(query)) ?? 0 > 0
    }
}

