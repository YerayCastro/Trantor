//
//  ImageVM.swift
//  Trantor
//
//  Created by Yery Castro on 2/12/23.
//

import SwiftUI

@Observable
final class ImageVM {
    var image: UIImage?
    
    let interactor: ImageInteractor
    
    init(interactor: ImageInteractor = ImageManager()) {
        self.interactor = interactor
    }
    
    func getImage(url: URL?) throws {
        // Compruebo si el fichero existe.
        guard let url else { return }
        let imageURL = URL.cachesDirectory.appending(path: url.lastPathComponent)
        if FileManager.default.fileExists(atPath: imageURL.path()) {
            let data = try Data(contentsOf: imageURL)
            // Asociamos la imágen.
            image = UIImage(data: data)
        } else {
            Task {
                // Recupero la imágen desde el interactor.
                let image = try await interactor.getImage(url: url)
                await MainActor.run {
                    self.image = image
                }
            }
        }
    }
}
