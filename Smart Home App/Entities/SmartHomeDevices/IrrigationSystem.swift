//
//  IrrigationSystem.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/22/21.
//

import Foundation

final class IrrigationSystem: SmartHomeDevice {

    // MARK: - Init

    init(name: String, code: String) {
        super.init(name: name, code: code, image: AppConstants.Images.irrigationSystem)
    }

    init(name: String, code: String, isLoved: Bool, isTurnedOn: Bool) {
        super.init(name: name,
                   code: code,
                   image: AppConstants.Images.irrigationSystem,
                   isLoved: isLoved,
                   isTurnedOn: isTurnedOn)
    }
}
