//
//  CurtainsInteractor.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 5/10/21.
//

import UIKit

protocol ICurtainsInteractor {
    func loadInitData()
    func toggleCurtains()
    func setLevel(_ level: Int)
    func getDeviceName() -> String
    func saveData()
    func sliderDidEndGesture(withValue value: Int)

    func getDevice() -> SmartHomeDevice
    func changeDeviceName(_ newName: String)
    func deleteDevice()
}

protocol ICurtainsInteractorOuter: AnyObject {
    func prepareView(curtains: Curtains)
    func changeLevelTo(_ level: Int)
    func reloadCurtainsInfo(curtains: Curtains)
    func goToPreviousVC()
    func showAlertWith(message: String)
}

final class CurtainsInteractor {

    // MARK: - Properties

    weak var presenter: ICurtainsInteractorOuter?
    private var curtains: Curtains
    private let firebaseManager = FirebaseDatabaseManager()
    private let delegate: IReloadAfterRemovedDevice

    // MARK: - Init

    init(curtains: Curtains, delegate: IReloadAfterRemovedDevice) {
        self.curtains = curtains
        self.delegate = delegate
    }
}

// MARK: - ICurtainsInteractor

extension CurtainsInteractor: ICurtainsInteractor {
    func loadInitData() {
        self.presenter?.prepareView(curtains: self.curtains)
    }

    func toggleCurtains() {
        self.curtains.toggleDevice()
        self.presenter?.reloadCurtainsInfo(curtains: self.curtains)
    }

    func setLevel(_ level: Int) {
        self.curtains.setLevel(level)
        self.presenter?.changeLevelTo(level)
    }

    func getDeviceName() -> String {
        return self.curtains.name
    }

    func saveData() {
        self.firebaseManager.saveDevice(self.curtains)
    }

    func sliderDidEndGesture(withValue value: Int) {
        self.curtains.setLevel(value)
        self.saveData()
    }

    func getDevice() -> SmartHomeDevice {
        return self.curtains
    }

    func changeDeviceName(_ newName: String) {
        self.curtains.changeName(newName)
        self.saveData()
    }

    func deleteDevice() {
        self.delegate.reloadAfterDelete(withDevice: self.curtains)
        self.presenter?.goToPreviousVC()
    }
}
