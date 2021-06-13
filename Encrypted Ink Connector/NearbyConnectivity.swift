// Copyright © 2021 Encrypted Ink. All rights reserved.

import Foundation
import MultipeerConnectivity

private let serviceIdentifier = "connector"
private let queue = DispatchQueue(label: serviceIdentifier, qos: .default)

class NearbyConnectivity: NSObject {
    
    private var devicePeerID: MCPeerID!
    private var serviceAdvertiser: MCNearbyServiceAdvertiser!
    
    init(link: String) {
        super.init()
        devicePeerID = MCPeerID(displayName: UUID().uuidString)
        
        serviceAdvertiser = MCNearbyServiceAdvertiser(peer: devicePeerID, discoveryInfo: ["wclink": link], serviceType: serviceIdentifier)
        
        autoConnect()
    }
    
    deinit {
        stopAdvertising()
    }
    
    private func stopAdvertising() {
        serviceAdvertiser.stopAdvertisingPeer()
    }
    
    private func autoConnect() {
        queue.async { [weak self] in
            self?.serviceAdvertiser.startAdvertisingPeer()
        }
    }
    
}
