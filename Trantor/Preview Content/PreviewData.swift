//
//  PreviewData.swift
//  Trantor
//
//  Created by Yery Castro on 23/11/23.
//

import SwiftUI

extension Book {
    static let test = Book(
        author: UUID(uuidString: "529E6C18-1D27-4056-BB47-9173637E4D5C")!,
        year: 1912,
        id: 3,
        title: "A Princess of Mars",
        isbn: "0143104888",
        pages: 186,
        rating: 3.8,
        price: 26.97,
        cover: URL(string: "https://images.gr-assets.com/books/1332272118l/40395.jpg"),
        plot: "John Carter, a Confederate veteran of the American Civil War, goes prospecting in Arizona immediately after the war's end...",
        summary: "A Princess of Mars is a science fantasy novel by American writer Edgar Rice Burroughs, the first of his Barsoom series..."
    )
}
// Extensión para los datos de prueba del autor.
extension Author {
    static let test = Author(id: UUID(uuidString: "529E6C18-1D27-4056-BB47-9173637E4D5C")!, name: "Edgar Rice Burroughs")
}

struct DataTest: DataInteractor {
    let urlBooks = Bundle.main.url(forResource: "testingBooks", withExtension: "json")!
    let urlAuthors = Bundle.main.url(forResource: "testingAuthors", withExtension: "json")!
    
    func loadTestData<JSON>(url: URL) throws -> JSON where JSON: Codable {
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(JSON.self, from: data)
    }
    
    func getBooks() async throws -> [Book] {
         try loadTestData(url: urlBooks)
    }
    
    func getAuthors() async throws -> [Author] {
        try loadTestData(url: urlAuthors)
    }
}

extension TrantorVM {
    static let preview = TrantorVM(interactor: DataTest())
}

extension ContentView {
    static var preview: some View {
        let vm = TrantorVM.preview
        return ContentView()
            .task {
                await vm.getData()
            }
            .environment(vm)
    }
}

extension TrantorMain {
    static var preview: some View {
        let vm = TrantorVM.preview
        return TrantorMain()
            .task {
                await vm.getData()
            }
            .environment(vm)
    }
}
