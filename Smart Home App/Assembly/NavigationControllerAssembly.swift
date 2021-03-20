//
//  NavigationControllerAssembly.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/20/21.
//

import UIKit

enum NavigationControllerAssembly {
    static func createNavigationVC(for vc: UIViewController) -> UINavigationController {
        UINavigationController(rootViewController: vc)
    }
}
