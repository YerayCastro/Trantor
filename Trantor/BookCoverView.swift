//
//  BookCoverView.swift
//  Trantor
//
//  Created by Yery Castro on 27/11/23.
//

import SwiftUI

struct BookCoverView: View {
    let cover: Image
    let book: Book
    var big: Bool = false
    
    var body: some View {
        cover
            .resizable()
            .scaledToFill()
            .frame(width: big ? 250 : 150, height: big ? 420 : 230)
            .overlay(alignment: .bottom) {
                if !big {
                    BottomTitleView(title: book.title)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: .black.opacity(0.3), radius: 5, x: 0.0, y: 5)
            .frame(height: big ? 420 :  250)
    }
}

#Preview {
    BookCoverView(cover: Image(._40395), book: .test)
}
