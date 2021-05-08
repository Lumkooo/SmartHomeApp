//
//  AppInfoVCAssembly.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 5/8/21.
//

import UIKit

enum AppInfoVCAssembly {
    static func createVC() -> UIViewController {
        let appInfoViewContorller = AppInfoViewController()
        return appInfoViewContorller
    }
}
