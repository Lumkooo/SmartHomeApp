//
//  ElectricalSocket.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/21/21.
//

import Foundation

final class ElectricalSocket: SmartHomeDevice {

    // MARK: - Init

    init(name: String, code: String) {
        super.init(name: name, code: code, image: AppConstants.Images.electricalSocket)
    }

    init(name: String, code: String, isLoved: Bool, isTurnedOn: Bool) {
        super.init(name: name,
                   code: code,
                   image: AppConstants.Images.electricalSocket,
                   isLoved: isLoved,
                   isTurnedOn: isTurnedOn)
    }
}
