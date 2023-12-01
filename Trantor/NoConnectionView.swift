//
//  NoConnectionView.swift
//  Trantor
//
//  Created by Yery Castro on 30/11/23.
//

import SwiftUI

struct NoConnectionView: View {
    var body: some View {
        ContentUnavailableView("No Internet",
                               systemImage: "wifi.exclamationmark",
                               description: Text("There's no internet connection at this moment. This app must have internet connection in order to work properly."))
    }
}

#Preview {
    NoConnectionView()
}
