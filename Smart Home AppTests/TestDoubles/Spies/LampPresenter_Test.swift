//
//  LampPresenter_Test.swift
//  Smart Home AppTests
//
//  Created by Андрей Шамин on 5/22/21.
//

import Foundation
import UIKit
@testable import Smart_Home_App

class LampPresenter_Test: ILampPresenter {

    // MARK: - Properties

    private(set) var ui: ILampView?

    // ILampPresenter
    private(set) var isViewLoaded: Bool = false
    private(set) var isViewAppeared: Bool = false
    private(set) var deviceName: String = "SomeDevice"
    private(set) var isDataSaved: Bool = false
    private(set) var isInfoGet: Bool = false
    private(set) var isRenamed: Bool = false
    private(set) var isDeleted: Bool = false

    // ILampInteractorOuter
    private(set) var isViewPrepearing: Bool = false
    private(set) var isLightColorChanging: Bool = false
    private(set) var isLightLevelChanging: Bool = false
    private(set) var isGoingToChangeColorVC: Bool = false
    private(set) var isLampInfoReloading: Bool = false
    private(set) var isGoingToPreviousVC: Bool = false
    private(set) var isAlertWithMessageShowing: Bool = false

    // ILampRouterOuter
    private(set) var isDeviceNameChanging: Bool = false
    private(set) var isDeviceDeleting: Bool = false

    // MARK: - Public methods

    func viewDidLoad(ui: ILampView) {
        self.ui = ui
        self.isViewLoaded = true
    }

    func viewDidAppear() {
        self.isViewAppeared = true
    }

    func getDeviceName() -> String {
        return deviceName
    }

    func saveData() {
        self.isDataSaved = true
    }

    // Can not make unit test for UI elements
    func getInfo() {
        self.isInfoGet = true
    }

    func rename() {
        self.isRenamed = true
    }

    func delete() {
        self.isDeleted = true
    }
}

// MARK: - ILampInteractorOuter

extension LampPresenter_Test: ILampInteractorOuter {

    func prepareView(lamp: Lamp) {
        self.isViewPrepearing = true
    }

    func changeLightColorTo(_ color: UIColor) {
        self.isLightColorChanging = true
    }

    func changeLightLevelTo(_ level: Int) {
        self.isLightLevelChanging = true
    }

    func goToChangeColorVC(delegate: ColorChooserDelegate) {
        self.isGoingToChangeColorVC = true
    }

    func reloadLampInfo(lamp: Lamp) {
        self.isLampInfoReloading = true
    }

    func goToPreviousVC() {
        self.isGoingToPreviousVC = true
    }

    func showAlertWith(message: String) {
        self.isAlertWithMessageShowing = true
    }
}

// MARK: - ILampRouterOuter

extension LampPresenter_Test: ILampRouterOuter {
    func changeDeviceName(newName: String) {
        self.isDeviceNameChanging = true
    }

    func deleteDevice() {
        self.isDeviceDeleting = true
    }
}
