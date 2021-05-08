//
//  LoginEntitie.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/20/21.
//

import Foundation

struct LoginEntitie {
    let email: String
    let password: String

    var devices: [SmartHomeDevice] = []
}
