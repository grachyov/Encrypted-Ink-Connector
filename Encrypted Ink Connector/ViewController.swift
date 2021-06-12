// Copyright © 2021 Encrypted Ink. All rights reserved.

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var connectionLabel: UILabel!
    @IBOutlet weak var blinkingView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connectionLabel.text = "Connecting\nwith MacOS"
        startBlinking()
    }

    func showAlertIfNeeded() {
        guard launchURL != nil else { return }
        let url = launchURL
        launchURL = nil
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Hello", message: url?.absoluteString, preferredStyle: .alert)
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
