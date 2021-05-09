//
//  IMainInteractorRemovedDevice.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 5/9/21.
//

import Foundation

protocol IReloadAfterRemovedDevice {
    func reloadAfterDelete(withDevice device: SmartHomeDevice)
}
