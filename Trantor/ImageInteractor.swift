//
//  ImageInteractor.swift
//  Trantor
//
//  Created by Yery Castro on 2/12/23.
//

import SwiftUI
/*:
 Para poder recuperar sólo una imágen
 */

protocol ImageInteractor {
    func getImage(url: URL) async throws -> UIImage?
}

struct ImageManager: ImageInteractor {
    func getImage(url: URL) async throws -> UIImage? {
        // Recupero la imágen de la url.
        // Primero obtengo el data.
        // Recupero la imágen síncrona. Se recupera la imágen de la carpeta de caché. let cache = URL.cachesDirectory.
        
        let imageURL = URL.cachesDirectory.appending(path: url.lastPathComponent)
        let (data, _) = try await URLSession.shared.getData(from: url)
        // Compruebo que la imágen existe.
        if let image = UIImage(data: data),
           // Compruebo que la imágen es valida
           let jpgData = image.jpegData(compressionQuality: 0.7) {
            try jpgData.write(to: imageURL, options: .atomic)
            return image
        } else {
            return nil
        }
    }
}



