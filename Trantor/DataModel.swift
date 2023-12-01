//
//  DataModel.swift
//  Trantor
//
//  Created by Yery Castro on 28/11/23.
//

import Foundation
import SwiftData

// Para crear la tabla de libros.(BooksData). Hay que poner encima del nombre de la clase @Model
@Model
final class BooksData {
    // No puede haber dos datos iguales.
    @Attribute(.unique) let id: Int
    var title: String
    // Creo la relación con la tabla, de AuthorData
    @Relationship(deleteRule: .nullify) var author: AuthorData?
    var plot: String?
    var summary: String?
    var year: Int
    var isbn: String?
    var pages: Int?
    var rating: Double?
    var price: Double
    var cover: URL?
    
    init(id: Int, title: String, author: AuthorData?, plot: String?, summary: String?, year: Int, isbn: String?, pages: Int?, rating: Double?, price: Double, cover: URL?) {
        self.id = id
        self.title = title
        self.author = author
        self.plot = plot
        self.summary = summary
        self.year = year
        self.isbn = isbn
        self.pages = pages
        self.rating = rating
        self.price = price
        self.cover = cover
    }
    
    convenience init(book: Book, author: AuthorData? = nil) {
        self.init(id: book.id,
                  title: book.title,
                  author: author,
                  plot: book.plot,
                  summary: book.summary,
                  year: book.year,
                  isbn: book.isbn,
                  pages: book.pages,
                  rating: book.rating,
                  price: book.price,
                  cover: book.cover)
    }
}

@Model
final class AuthorData {
    let id: UUID
    var name: String
    
    // Para crear la relación inversa, hay que ponerlo aparte cuando la relación es 1 a N. Hay que hacer referencia a la clase(BooksData) y al campo(author). La variable creada va a ser un array del tipo de la clase([BooksData]). Es obligatorio que sea opcional.
    @Relationship(inverse: \BooksData.author) var books: [BooksData]?
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
    
    convenience init(author: Author) {
        self.init(id: author.id, name: author.name)
    }
}

// Para crear la relación de N a N. Hay que crear una tabla auxiliar(LibrosAutores)
@Model
final class Libro {
    @Attribute(.unique) let id: Int
    let name: String
    // Creo la relación inversa
    @Relationship(inverse: \LibrosAutores.autor) var autores: [LibrosAutores]?
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

// Tabla pivote(LibrosAutores), para relacionar la tabla(Libro) y la tabla(Autor). se crean en esta tabla las relaciones
@Model
final class LibrosAutores {
    @Relationship(deleteRule: .deny) let libro: Libro
    @Relationship(deleteRule: .deny) let autor: Autor
    
    init(libro: Libro, autor: Autor) {
        self.libro = libro
        self.autor = autor
    }
}

@Model
final class Autor {
    @Attribute(.unique) let id: Int
    let name: String
    @Relationship(inverse: \LibrosAutores.libro) var libros: [LibrosAutores]?
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
