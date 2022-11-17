//
//  SceneDelegate.swift
//  AlefDevelopment
//
//  Created by pavel mishanin on 25.10.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = InfoAssembly.build()
        window?.makeKeyAndVisible()
    }
}
