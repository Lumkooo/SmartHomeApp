//
//  LampInteractorTest.swift
//  Smart Home AppTests
//
//  Created by Андрей Шамин on 5/22/21.
//

import XCTest
@testable import Smart_Home_App

class LampInteractorTest: XCTestCase {

    // MARK: - Properties

    private var sut: LampInteractor!
    private var presenter: LampPresenter_Test!
    private var lamp: Lamp = Lamp(name: "Lamp", code: "121-232-232")
    private var deviceIsDeleted = false

    // MARK: - Methods

    override func setUp() {
        super.setUp()
        self.presenter = LampPresenter_Test()

        let interactor = LampInteractor(lamp: lamp, delegate: self)
        interactor.presenter = self.presenter
        self.sut = interactor
    }

    override func tearDown() {
        self.sut = nil
        self.presenter = nil

        super.tearDown()
    }

    func testLoadInitDataMethod() throws {
        self.sut!.loadInitData()
        XCTAssertTrue(self.presenter!.isViewPrepearing)
    }

    func testToggleLampMethod() throws {
        let lampState = self.lamp.isTurnedOn
        self.sut!.toggleLamp()
        let newState = self.lamp.isTurnedOn
        XCTAssertEqual(!lampState, newState)
        XCTAssertTrue(self.presenter!.isLampInfoReloading)
    }

    func testSetLightLevelMethod() throws {
        self.sut!.setLightLevel(50)
        XCTAssertEqual(self.lamp.lightLevel, 50)
    }


    func testSetLightColorMethod() throws {
        self.sut!.setLightColor(.blue)
        XCTAssertEqual(self.lamp.lightColor, .blue)
    }

    func testColorChangeButtonPressedMethod() throws {
        self.sut!.colorChangeButtonPressed()
        XCTAssertTrue(self.presenter!.isGoingToChangeColorVC)
    }

    func testGetdeviceNameMethod() throws {
        let name = self.sut!.getDeviceName()
        XCTAssertEqual(self.lamp.name, name)
    }

    func testSaveDataMethod() throws {
//        self.sut!.saveData()
//        XCTAssertTrue(self.presenter!.isGoingToChangeColorVC)
    }

    func testSliderDidEndGestureMethod() throws {
        let oldValue = self.lamp.lightLevel
        let newValue = 99
        self.sut!.sliderDidEndGesture(withValue: newValue)
        XCTAssertNotEqual(oldValue, self.lamp.lightLevel)
    }

    func testGetDeviceMethod() throws {
        let lamp = self.sut!.getDevice()
        XCTAssertEqual(self.lamp, lamp)
    }

    func testChangeDeviceNameMethod() throws {
        let lampOldName = self.lamp.name
        self.sut!.changeDeviceName("something new!")
        XCTAssertNotEqual(lampOldName, self.lamp.name)
    }

    func testDeleteDeviceMethod() throws {
        self.sut!.deleteDevice()
        XCTAssertTrue(self.deviceIsDeleted)
        XCTAssertTrue(self.presenter!.isGoingToPreviousVC)
    }

    func testColorDidChangeToMethod() throws {
        self.sut!.colorDidChangeTo(.white)
        XCTAssertTrue(self.presenter!.isLightColorChanging)
    }
}

// MARK: - IReloadAfterRemovedDevice

extension LampInteractorTest: IReloadAfterRemovedDevice {
    func reloadAfterDelete(withDevice device: SmartHomeDevice) {
        self.deviceIsDeleted = true
    }
}

