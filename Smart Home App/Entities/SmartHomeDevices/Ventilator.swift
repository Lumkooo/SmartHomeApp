//
//  Ventilator.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/22/21.
//

import Foundation

final class Ventilator: SmartHomeDevice {

    // MARK: - Init

    init(name: String, code: String) {
        super.init(name: name, code: code, image: AppConstants.Images.ventilator)
    }
}
