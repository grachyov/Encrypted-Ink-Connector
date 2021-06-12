// Copyright © 2021 Encrypted Ink. All rights reserved.

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var connectionLabel: UILabel!
    @IBOutlet weak var blinkingView: UIView!
    
    private var connectivity: NearbyConnectivity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connectionLabel.text = "Connecting\nwith MacOS"
        startBlinking()
    }

    func showAlertIfNeeded() {
        guard let url = launchURL else { return }
        launchURL = nil
        connectivity = NearbyConnectivity(link: url.absoluteString)
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Hello", message: url.absoluteString, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func startBlinking() {
        Timer.scheduledTimer(withTimeInterval: 0.75, repeats: true) { [weak self] _ in
            self?.blinkingView.isHidden.toggle()
            self?.showAlertIfNeeded()
        }
    }
    
}
