//
//  MainInteractor.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/21/21.
//

import Foundation

protocol IMainInteractor {
    func loadInitData()
    func cellTappedAt(_ indexPath: IndexPath)
    func toggleIsLikedState(atIndexPath indexPath: IndexPath)
    func getDevice(atIndexPath indexPath: IndexPath) -> SmartHomeDevice?
}

protocol IMainInteractorOuter: AnyObject {
    func reloadView(devices: [SmartHomeDevice])
}

final class MainInteractor {

    // MARK: - Properties

    weak var presenter: IMainInteractorOuter?
    private let lovedDevicesDelegate: ILovedDevicesDelegate
    private let firebaseManager = FirebaseDatabaseManager()

    init(lovedDevicesDelegate: ILovedDevicesDelegate) {
        self.lovedDevicesDelegate = lovedDevicesDelegate
    }
}

// MARK: - IMainInteractor

extension MainInteractor: IMainInteractor {

    func loadInitData() {
//        firebaseManager.saveAirConditioner(AirConditioner(name: "Кондиционер", code: "340-908-231"), completion: {
//            print("DONE1")
//        })
//        firebaseManager.saveElectricalSocket(ElectricalSocket(name: "Розетка", code: "001-435-593")) {
//            print("DONE2")
//        }
//        firebaseManager.saveAirConditioner(AirConditioner(name: "Кондиционер", code: "340-908-231"), completion: {
//            print("DONE1")
//        })
//        firebaseManager.saveIrrigationSystemManager(IrrigationSystem(name: "Система полива", code: "211-112-142")) {
//            print("DONE2")
//        }
//        firebaseManager.saveCurtains(Curtains(name: "Шторы", code: "539-031-324")) {
//            print("DONE3")
//        }
//        firebaseManager.saveVentilator(Ventilator(name: "Вентилятор", code: "882-213-493")) {
//            print("DONE4")
//        }

        firebaseManager.getDevices { (devices) in
            self.presenter?.reloadView(devices: devices)
        } errorCompletion: {

        }
//        self.presenter?.reloadView(devices: self.getDevices())

    }

    func getDevice(atIndexPath indexPath: IndexPath) -> SmartHomeDevice? {
        DevicesManager.shared.getDevice(atIndex: indexPath.item)
    }

    func cellTappedAt(_ indexPath: IndexPath) {
        let index = indexPath.row
        self.toggleDeviceState(index: index)
        self.presenter?.reloadView(devices: self.getDevices())
    }
    
    func toggleIsLikedState(atIndexPath indexPath: IndexPath) {
        DevicesManager.shared.toggleIsLovedForDeviceAt(index: indexPath.item)
        self.updateLovedDevicesScreen()
    }
}

private extension MainInteractor {
    // Переключает состояние устройства (включено/выключено)
    func toggleDeviceState(index: Int) {
        DevicesManager.shared.toggleDeviceState(atIndex: index)
        self.lovedDevicesDelegate.reloadData()
    }

    func getDevices() -> [SmartHomeDevice] {
        return DevicesManager.shared.getDevices()
    }

    func updateLovedDevicesScreen() {
        self.lovedDevicesDelegate.reloadData()
    }
}

