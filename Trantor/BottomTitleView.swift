//
//  BottomTitleView.swift
//  Trantor
//
//  Created by Yery Castro on 27/11/23.
//

import SwiftUI

struct BottomTitleView: View {
    let title: String
    
    var body: some View {
        Rectangle()
            .fill(.white.opacity(0.7))
            .frame(height: 50)
            .overlay(alignment: .top) {
                VStack {
                    Text(title)
                        .font(.caption)
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
    BottomTitleView(title: "A princess of Mars")
}
