//
//  BottomTitleView.swift
//  Trantor
//
//  Created by Yery Castro on 27/11/23.
//

import SwiftUI

struct BottomTitleView: View {
    let title: String
    let id: Int
    let namespace: Namespace.ID
    var body: some View {
        Rectangle()
            .fill(.white.opacity(0.7))
            .frame(height: 50)
            .overlay(alignment: .top) {
                VStack {
                    Text(title)
                        .font(.caption)
                        .matchedGeometryEffect(id: "title\(id)", in: namespace)
                        .foregroundStyle(.black)
                        .bold()
                        .lineLimit(2)
                        .minimumScaleFactor(0.7)
                        .multilineTextAlignment(.center)
                }
                .padding(2)
            }
    }
}

#Preview {
    BottomTitleView(title: "A princess of Mars", id: 1, namespace: Namespace().wrappedValue)
}
