//
//  LampViewControllerTest.swift
//  Smart Home AppTests
//
//  Created by Андрей Шамин on 5/22/21.
//

import XCTest
@testable import Smart_Home_App

class LampViewControllerTest: XCTestCase {
    // MARK: - Properties

    private var sut: LampViewController!
    private var presenter: LampPresenter_Test!

    // MARK: - Methods

    override func setUp() {
        super.setUp()
        self.presenter = LampPresenter_Test()
        let viewController = LampViewController(presenter: self.presenter)
        self.sut = viewController
    }

    override func tearDown() {
        self.sut = nil
        self.presenter = nil

        super.tearDown()
    }

    func testViewDidLoaded() throws {
        self.sut!.viewDidLoad()
        XCTAssertNotNil(self.presenter!.ui, "UI is nil!")
        XCTAssertTrue(self.presenter!.isViewLoaded, "View didn't loaded")
    }

    func testViewDidAppear() throws {
        self.sut!.viewDidAppear(true)
        XCTAssertTrue(self.presenter!.isViewAppeared, "View didn't appear")
    }

    func testViewWillDissapear() throws {
        self.sut!.viewWillDisappear(true)
        XCTAssertTrue(self.presenter!.isDataSaved, "Data isn't saved")
    }

    func testGetDeviceName() throws {
        self.sut!.viewDidLoad()
        let vcTitle = self.sut!.title
        XCTAssertEqual(vcTitle, self.presenter!.deviceName, "Not the same")
    }
}
