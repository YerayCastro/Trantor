//
//  BookPlaceholder.swift
//  Trantor
//
//  Created by Yery Castro on 27/11/23.
//

import SwiftUI

struct BookPlaceholder: View {
    let book: Book
    let namespace: Namespace.ID
    
    var body: some View {
        Image(systemName: "book")
            .resizable()
            .scaledToFit()
            .padding()
            .frame(width: 150, height: 230)
            .background {
                Rectangle()
                    .fill(Color(white: 0.9))
            }
            .overlay(alignment: .bottom) {
                BottomTitleView(title: book.title, id: book.id, namespace: namespace)
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: .black.opacity(0.3), radius: 5, x: 0.0, y: 5)
            .frame(height: 250)
    }
}

#Preview {
    BookPlaceholder(book: .test, namespace: Namespace().wrappedValue)
}
