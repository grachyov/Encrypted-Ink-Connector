// Copyright © 2021 Encrypted Ink. All rights reserved.

import UIKit

var launchURL: URL?

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        processURLContexts(connectionOptions.urlContexts)
        guard (scene as? UIWindowScene) != nil else { return }
    }
    
    private func processURLContexts(_ URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            launchURL = url
        }
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        processURLContexts(URLContexts)
    }
    
}
