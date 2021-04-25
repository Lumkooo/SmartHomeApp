//
//  AlertAssembly.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/20/21.
//

import UIKit

enum AlertAssembly {
    static func createSimpleAlert(withMessage message: String) -> UIAlertController {
        let alert = UIAlertController(title: Localized("error"),
                                      message: message,
                                      preferredStyle: .alert)
        let alertAction = UIAlertAction(title: Localized("ok"), style: .default)
        alert.addAction(alertAction)
        return alert
    }
}
