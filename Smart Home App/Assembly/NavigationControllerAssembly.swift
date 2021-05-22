//
//  NavigationControllerAssembly.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/20/21.
//

import UIKit

enum NavigationControllerAssembly {
    static func createNavigationVC(for vc: UIViewController, prefersLargeTitles: Bool = true) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.navigationBar.tintColor = .label
        navigationController.navigationBar.prefersLargeTitles = prefersLargeTitles
        navigationController.navigationBar.accessibilityIdentifier = "NavigationBarID"
        return navigationController
    }
}
