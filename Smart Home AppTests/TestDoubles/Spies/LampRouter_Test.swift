//
//  LampRouter_Test.swift
//  Smart Home AppTests
//
//  Created by Андрей Шамин on 5/22/21.
//

import Foundation
import UIKit

@testable import Smart_Home_App

class LampRouter_Test: ILampRouter {

    // MARK: - Properties

    private(set) var isDeviceInfoShowed: Bool = false
    private(set) var isRenameVCShowed: Bool = false
    private(set) var isDeleteAlertShowed: Bool = false
    private(set) var isChangeColorVCShowed: Bool = false
    private(set) var isAlertWithMessageShowed: Bool = false
    private(set) var isVCDismissed: Bool = false

    // MARK: - Public methods

    func showDeviceInfo(forDevice device: SmartHomeDevice) {
        self.isDeviceInfoShowed = true
    }

    func showRenameVC(forDevice device: SmartHomeDevice) {
        self.isRenameVCShowed = true
    }

    func showDeleteAlert(forDevice device: SmartHomeDevice) {
        self.isDeleteAlertShowed = true
    }

    func showChangeColorVC(delegate: ColorChooserDelegate) {
        self.isChangeColorVCShowed = true
    }

    func showAlertWith(message: String) {
        self.isAlertWithMessageShowed = true
    }

    func dismissVC() {
        self.isVCDismissed = true
    }
}
