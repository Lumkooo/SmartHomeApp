//
//  AlertAssembly.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/20/21.
//

import UIKit

enum AlertAssembly {
    static func createSimpleAlert(withMessage message: String, completion: (()-> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: Localized("error"),
                                      message: message,
                                      preferredStyle: .alert)
        let alertAction = UIAlertAction(title: Localized("ok"), style: .default) { (action) in
            completion?()
        }
        alert.addAction(alertAction)
        return alert
    }

    static func createDeviceInfoAlert(forDevice device: SmartHomeDevice,
                                      completion: (()-> Void)? = nil) -> UIAlertController {
        let message = "\(device.name)\n\(Localized("code")): \(device.code)"

        var title = ""
        switch device {
        case is Lamp:
            title = Localized("lamp")
        case is ElectricalSocket:
            title = Localized("electricalSocket")
        case is AirConditioner:
            title = Localized("airConditioner")
        case is Curtains:
            title = Localized("curtains")
        case is Ventilator:
            title = Localized("ventilator")
        case is IrrigationSystem:
            title = Localized("irrigationSystem")
        default:
            title = Localized("device")
        }
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let alertAction = UIAlertAction(title: Localized("ok"), style: .default) { (action) in
            completion?()
        }
        alert.addAction(alertAction)
        return alert
    }

    static func createRenameDeviceAlert(forDevice device: SmartHomeDevice,
                                        completion: ((String)-> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: Localized("deviceNameText"),
                                                message: nil,
                                                preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = Localized("enterNewName")
        }
        let saveAction = UIAlertAction(title: Localized("rename"),
                                       style: .default,
                                       handler: { alert -> Void in
                                        guard let textFields = alertController.textFields,
                                              !textFields.isEmpty,
                                              let text = textFields[0].text else {
                                            return
                                        }
                                        completion?(text)
                                       })
        let cancelAction = UIAlertAction(title: Localized("cancel"),
                                         style: .default) { (action) in

        }
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        return alertController
    }

    static func createDeleteDeviceAlert(forDevice device: SmartHomeDevice,
                                       completion: (()-> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: Localized("deleteAlertText"),
                                                message: nil,
                                                preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: Localized("delete"),
                                         style: .destructive){ (alert) in
            completion?()
        }
        let cancelAction = UIAlertAction(title: Localized("cancel"),
                                         style: .default) { (action) in

        }
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        return alertController
    }
}
