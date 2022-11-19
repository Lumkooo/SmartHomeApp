//
//  CurtainsPresenter.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 5/10/21.
//

import Foundation

protocol ICurtainsPresenter {
    func viewDidLoad(ui: ICurtainsView)
    func viewDidAppear()
    func getDeviceName() -> String
    func saveData()

    func getInfo()
    func rename()
    func delete()
}

final class CurtainsPresenter {

    // MARK: - Properties

    private let interactor: ICurtainsInteractor
    private let router: ICurtainsRouter
    private weak var ui: ICurtainsView?

    // MARK: - Init

    init(interactor: ICurtainsInteractor, router: ICurtainsRouter) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - ICurtainsPresenter

extension CurtainsPresenter: ICurtainsPresenter {
    func viewDidLoad(ui: ICurtainsView) {
        self.ui = ui
        self.ui?.toggleCurtains = { [weak self] in
            self?.interactor.toggleCurtains()
        }
        self.ui?.sliderDidChangeValue = { [weak self] newValue in
            self?.interactor.setLevel(newValue)
        }
        self.ui?.sliderDidEndGesture = { [weak self] newValue in
            self?.interactor.sliderDidEndGesture(withValue: newValue)
        }
    }

    func viewDidAppear() {
        self.interactor.loadInitData()
    }

    func getDeviceName() -> String {
        return self.interactor.getDeviceName()
    }

    func saveData() {
        self.interactor.saveData()
    }

    func getInfo() {
        let device = self.interactor.getDevice()
        self.router.showDeviceInfo(forDevice: device)
    }

    func rename() {
        let device = self.interactor.getDevice()
        self.router.showRenameVC(forDevice: device)
    }

    func delete() {
        let device = self.interactor.getDevice()
        self.router.showDeleteAlert(forDevice: device)
    }
}

// MARK: - ILampInteractorOuter

extension CurtainsPresenter: ICurtainsInteractorOuter {
    func reloadCurtainsInfo(curtains: Curtains) {
        self.ui?.changeInfo(curtains: curtains)
    }

    func prepareView(curtains: Curtains) {
        self.ui?.prepareView(curtains: curtains)
    }

    func changeLevelTo(_ level: Int) {
        self.ui?.changetLevelTo(level)
    }

    func showAlertWith(message: String) {
        self.router.showAlertWith(message: message)
    }

    func goToPreviousVC() {
        self.router.dismissVC()
    }
}

// MARK: - ICurtainsRouterOuter

extension CurtainsPresenter: ICurtainsRouterOuter {
    func changeDeviceName(newName: String) {
        self.interactor.changeDeviceName(newName)
    }

    func deleteDevice() {
        self.interactor.deleteDevice()
    }
}
