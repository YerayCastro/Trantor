//
//  SwiftDataPreview.swift
//  Trantor
//
//  Created by Yery Castro on 28/11/23.
//

import Foundation
import SwiftData

@MainActor
var testModelContainer: ModelContainer = {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: BooksData.self, configurations: config)
        
        let authorTest = AuthorData(author: .test)
        let bookTest = BooksData(book: .test, author: authorTest)
        
        container.mainContext.insert(bookTest)
        return container
    } catch {
        fatalError("Error creando la base de datos para preview.")
    }
}()
