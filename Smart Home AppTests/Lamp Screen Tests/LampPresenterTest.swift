//
//  LampPresenterTest.swift
//  Smart Home AppTests
//
//  Created by Андрей Шамин on 5/22/21.
//

import XCTest
@testable import Smart_Home_App

class LampPresenterTest: XCTestCase {
    
    // MARK: - Properties

    private var sut: LampPresenter!
    private var interactor: LampInteractor_Test!
    private var router: LampRouter_Test!
    private var ui: LampView_Test!
    private var lamp = Lamp(name: "Lamp", code: "121-121-212")

    // MARK: - Methods

    override func setUp() {
        super.setUp()
        self.interactor = LampInteractor_Test()
        self.router = LampRouter_Test()
        self.ui = LampView_Test()

        let presenter = LampPresenter(interactor: interactor, router: router)
        presenter.viewDidLoad(ui: self.ui)
        self.sut = presenter
    }

    override func tearDown() {
        self.sut = nil
        self.interactor = nil
        self.router = nil
        self.ui = nil

        super.tearDown()
    }

    func testViewDidLoadMethod() throws {
//        self.sut!.viewDidLoad(ui: self.ui)
        XCTAssertNotNil(self.sut!.ui, "View wasn't set")
    }

    func testViewDidAppearMethod() throws {
        self.sut!.viewDidAppear()
        XCTAssertTrue(self.interactor!.isInitDataLoaded)
    }

    func testGetDeviceNameMethod() throws {
        let deviceName = self.sut!.getDeviceName()
        XCTAssertEqual(deviceName, self.interactor.device.name)
        XCTAssertTrue(self.interactor!.isDeviceNameGet)
    }

    func testSaveDataMethod() throws {
        self.sut!.saveData()
        XCTAssertTrue(self.interactor!.isDataSaved)
    }

    func testGetInfoMethod() throws {
        self.sut!.getInfo()
        XCTAssertTrue(self.router!.isDeviceInfoShowed)
    }

    func testRenameMethod() throws {
        self.sut!.rename()
        XCTAssertTrue(self.router!.isRenameVCShowed)
    }

    func testDeleteMethod() throws {
        self.sut!.delete()
        XCTAssertTrue(self.router!.isDeleteAlertShowed)
    }

    func testPrepareView() throws {
        self.sut!.prepareView(lamp: self.lamp)
        XCTAssertTrue(self.ui!.isViewPreparedForLamp)
    }

    func testChangeLightColorView() throws {
        self.sut!.changeLightColorTo(.blue)
        XCTAssertTrue(self.ui!.isLightColorChanged)
    }

    func testChangeLightLevelView() throws {
        self.sut!.changeLightLevelTo(50)
        XCTAssertTrue(self.ui!.isLightLevelChanged)
    }

    func testGoToChangeColorVCMethod() throws {
        self.sut!.goToChangeColorVC(delegate: self)
        XCTAssertTrue(self.router!.isChangeColorVCShowed)
    }

    func testReloadLampInfo() throws {
        self.sut!.reloadLampInfo(lamp: self.lamp)
        XCTAssertTrue(self.ui.isLampInfoChangedOnView)
    }

    func testShowAlertWithMessageMethod() throws {
        self.sut!.showAlertWith(message: "Some message")
        XCTAssertTrue(self.router.isAlertWithMessageShowed)
    }

    func testGoToPreviousVCMethod() throws {
        self.sut!.goToPreviousVC()
        XCTAssertTrue(self.router.isVCDismissed)
    }

    func testChangeDeviceNameMethod() throws {
        let newName = "some name"
        self.sut!.changeDeviceName(newName: newName)
        XCTAssertEqual(self.interactor.device.name, newName)
        XCTAssertTrue(self.interactor.isDeviceNameChanged)
    }

    func testDeleteDeviceMethod() throws {
        self.sut!.deleteDevice()
        XCTAssertTrue(self.interactor.isDeviceDeleted)
    }
}

extension LampPresenterTest: ColorChooserDelegate {
    func colorDidChangeTo(_ color: UIColor) {
        //
    }
}

