// Copyright © 2021 Encrypted Ink. All rights reserved.

import UIKit
import QRCodeReader

class ViewController: UIViewController {

    @IBOutlet weak var connectionLabel: UILabel!
    @IBOutlet weak var blinkingView: UIView!
    
    private var connectivity: NearbyConnectivity?
    private var advertisedLink: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        connectionLabel.text = "Scan QR code\nto connect"
        startBlinking()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showScanner))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func showScanner() {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
            $0.showTorchButton = false
            $0.showSwitchCameraButton = false
            $0.showCancelButton = false
            $0.showOverlayView = false
            $0.rectOfInterest = CGRect(x: 0, y: 0, width: 1, height: 1)
        }
        let scanner = QRCodeReaderViewController(builder: builder)
        scanner.delegate = self
        scanner.modalPresentationStyle = .formSheet
        present(scanner, animated: true)
    }
    
    private func checkForNewLink() {
        if let link = wcLink {
            wcLink = nil
            startAdvertisingIfNeeded(link: link)
        }
    }
    
    private func startAdvertisingIfNeeded(link: String) {
        guard link.hasPrefix("wc") else { return }
        advertisedLink = link
        connectivity = NearbyConnectivity(link: link)
    }
    
    private func startBlinking() {
        Timer.scheduledTimer(withTimeInterval: 0.75, repeats: true) { [weak self] _ in
            self?.blinkingView.isHidden.toggle()
            self?.checkForNewLink()
        }
    }
    
}

extension ViewController: QRCodeReaderViewControllerDelegate {
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) { }
    
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        startAdvertisingIfNeeded(link: result.value)
        reader.dismiss(animated: true)
    }
    
}
