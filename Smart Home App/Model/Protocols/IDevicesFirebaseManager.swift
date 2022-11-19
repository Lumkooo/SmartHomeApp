//
//  IDevicesFirebaseManager.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/24/21.
//

import Foundation

protocol IDevicesFirebaseManager {
    func save(_ device: SmartHomeDevice, completion: (() -> Void)?)
    func get(completion: @escaping ([SmartHomeDevice]) -> Void, errorCompletion: @escaping () -> Void)
    func removeWithCode(_ code: String,
                        completion: @escaping () -> Void,
                        errorCompletion: @escaping (_ error: Error) -> Void)
}
