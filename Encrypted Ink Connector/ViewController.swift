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

    func startBlinking() {
        Timer.scheduledTimer(withTimeInterval: 0.75, repeats: true) { [weak self] _ in
            self?.blinkingView.isHidden.toggle()
        }
    }
    
}
