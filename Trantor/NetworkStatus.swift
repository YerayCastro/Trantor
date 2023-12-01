//
//  NetworkStatus.swift
//  Trantor
//
//  Created by Yery Castro on 30/11/23.
//

import SwiftUI
import Network
/*:
 Para saber si tengo o no tengo conexión a internet. Primero comprueba el estado, si es satisfied hay conexión y lo pone online, si cambia el estado, lo pone offline.
 */
@Observable
final class NetworkStatus {
    enum Status {
        case offline
        case online
        case unknow
    }
    
    var status: Status = .unknow
    
    // Constante que permite monitorizar los cambios de red.
    let monitor = NWPathMonitor()
    // Variable cola de proceso, para que este proceso esté continuamente ejecutandose en segundo plano.
    var queue = DispatchQueue(label: "MonitorNetwork")
    
    init() {
        monitor.start(queue: queue)
        // Clousure que recibe un path, que reacciona si hay algún cambio.Si hay cambio,lo ejecuta.
        monitor.pathUpdateHandler = { [self] path in
            // Hay que subirlo al hilo principal.
            DispatchQueue.main.async {
                self.status = path.status == .satisfied ? .online : .offline
            }
        }
        // Pregunto la disponibilidad de red. Si el estado es satisfactorio, devuelve online, sino offline.
        status = monitor.currentPath.status == .satisfied ? .online : .offline
    }
}
