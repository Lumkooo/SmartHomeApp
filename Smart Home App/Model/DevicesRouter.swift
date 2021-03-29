//
//  DevicesRouter.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/28/21.
//

import UIKit

final class DevicesRouter {

    func getViewControllerFor(device: SmartHomeDevice) -> UIViewController? {
        if device is Lamp {
            guard let lamp = device as? Lamp else {
                assertionFailure("Can't downcast device to lamp")
                return nil
            }
            let vc = LampScreenAssembly.createVC(lamp: lamp)
            return vc
        } else if device is ElectricalSocket {
            guard let electricalSocket = device as? ElectricalSocket else {
                assertionFailure("Can't downcast device to electrical socket")
                return nil
            }
            let vc = ElectricalSocketAssembly.createVC(electricalSocket: electricalSocket)
            return vc
        } else {
            print("can't downcast yet")
            return nil
        }
    }
}
