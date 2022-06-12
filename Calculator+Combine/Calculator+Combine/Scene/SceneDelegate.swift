//
//  SceneDelegate.swift
//  Calculator+Combine
//
//  Created by 김도연 on 2022/06/07.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = CalculatorViewController()
        window?.makeKeyAndVisible()
    }
}

