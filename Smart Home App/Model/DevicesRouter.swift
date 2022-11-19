//
//  DevicesRouter.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/28/21.
//

import UIKit

final class DevicesRouter {

    func getViewControllerFor(device: SmartHomeDevice, delegate: IReloadAfterRemovedDevice) -> UIViewController? {
        if device is Lamp {
            guard let lamp = device as? Lamp else {
                assertionFailure("Can't downcast device to lamp")
                return nil
            }
            let vc = LampScreenAssembly.createVC(lamp: lamp, delegate: delegate)
            return vc
        } else if device is AirConditioner {
            guard let airConditioner = device as? AirConditioner else {
                assertionFailure("Can't downcast device to lamp")
                return nil
            }
            let vc = AirConditionerAssembly.createVC(airConditioner: airConditioner, delegate: delegate)
            return vc
        } else if device is Curtains {
            guard let curtains = device as? Curtains else {
                assertionFailure("Can't downcast device to curtains")
                return nil
            }
            let vc = CurtainsVCAssembly.createVC(curtains: curtains, delegate: delegate)
            return vc
        } else {
            // Устройства, у которых нет детальной настройки - только включение/выключение
            let vc = SimpleDeviceAssembly.createVC(device: device, delegate: delegate)
            return vc
        }
    }
}
