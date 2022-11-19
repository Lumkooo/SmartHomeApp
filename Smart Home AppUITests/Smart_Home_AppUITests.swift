//
//  Smart_Home_AppUITests.swift
//  Smart Home AppUITests
//
//  Created by Андрей Шамин on 3/20/21.
//

import XCTest
@testable import Smart_Home_App

class Smart_Home_AppUITests: XCTestCase {

    func testSwipe() throws {
        let app = XCUIApplication()
        app.launch()
        let mainViewSmartHomeItemsCollectionView = XCUIApplication().collectionViews["MainViewSmartHomeItemsCollectionView"]
        mainViewSmartHomeItemsCollectionView.swipeUp()
        mainViewSmartHomeItemsCollectionView.swipeDown()
    }

    func testTapOnCell() throws {
        let app = XCUIApplication()
        app.launch()
        let mainViewSmartHomeItemsCollectionView = XCUIApplication().collectionViews["MainViewSmartHomeItemsCollectionView"]

        let mainViewSmartHomeItemsCollectionViewCell = mainViewSmartHomeItemsCollectionView.children(matching: .cell).element(boundBy: 0).otherElements.containing(.image, identifier:"collectionViewCellImageView").element
        mainViewSmartHomeItemsCollectionViewCell.tap()
    }

    func testAddDeviceScreen() throws {
        let app = XCUIApplication()
        app.launch()

        let navigationbaridNavigationBar = XCUIApplication().navigationBars["NavigationBarID"]
        navigationbaridNavigationBar.buttons["AddButtonIdentifier"].tap()
        navigationbaridNavigationBar.buttons.firstMatch.tap()
    }

    func testTabBarSecondSection() throws {
        let app = XCUIApplication()
        app.launch()
        XCUIApplication().tabBars["TabBarID"].buttons["LovedTab"].tap()

    }

    func testTabBarThirdSection() throws {
        let app = XCUIApplication()
        app.launch()
        XCUIApplication().tabBars["TabBarID"].buttons["ProfileTab"].tap()
    }

    func testTabBarFirstSection() throws {
        let app = XCUIApplication()
        app.launch()
        XCUIApplication().tabBars["TabBarID"].buttons["LovedTab"].tap()
        XCUIApplication().tabBars["TabBarID"].buttons["MainTab"].tap()
    }

    func testLikedCollectionViewScroll() throws {
        let app = XCUIApplication()
        app.launch()
        XCUIApplication().tabBars["TabBarID"].buttons["LovedTab"].tap()
        let mainViewSmartHomeItemsCollectionView = XCUIApplication().collectionViews["MainViewSmartHomeItemsCollectionView"]
        mainViewSmartHomeItemsCollectionView.swipeUp()
        mainViewSmartHomeItemsCollectionView.swipeDown()
    }

    func testLikedCollectionViewTap() throws {
        let app = XCUIApplication()
        app.launch()
        sleep(5)
        XCUIApplication().tabBars["TabBarID"].buttons["LovedTab"].tap()
        let mainViewSmartHomeItemsCollectionView = XCUIApplication().collectionViews["MainViewSmartHomeItemsCollectionView"]

        let mainViewSmartHomeItemsCollectionViewCell = mainViewSmartHomeItemsCollectionView.children(matching: .cell).element(boundBy: 0).otherElements.containing(.image, identifier:"collectionViewCellImageView").element
        mainViewSmartHomeItemsCollectionViewCell.tap()
    }

    func testMenuOpenAndClose() throws {
        let app = XCUIApplication()
        app.launch()

        XCUIApplication().navigationBars["NavigationBarID"].buttons["MenuButtonIdentifier"].tap()
        sleep(2)
        XCUIApplication().buttons["CloseViewButton"].tap()
    }

    func testMenuGetAppInfo() throws {
        let app = XCUIApplication()
        app.launch()

        XCUIApplication().navigationBars["NavigationBarID"].buttons["MenuButtonIdentifier"].tap()
        sleep(2)
        XCUIApplication().buttons["getAppInfo"].tap()
        XCUIApplication().navigationBars["NavigationBarID"].buttons.firstMatch.tap()
    }

    func testMenuSendError() throws {
        let app = XCUIApplication()
        app.launch()

        XCUIApplication().navigationBars["NavigationBarID"].buttons["MenuButtonIdentifier"].tap()
        sleep(2)
        XCUIApplication().buttons["sendError"].tap()
        XCUIApplication().navigationBars["NavigationBarID"].buttons.firstMatch.tap()
    }

    func testLongPressGesture() throws {

        let app = XCUIApplication()
        app.launch()
        let mainViewSmartHomeItemsCollectionView = XCUIApplication().collectionViews["MainViewSmartHomeItemsCollectionView"]

        let mainViewSmartHomeItemsCollectionViewCell = mainViewSmartHomeItemsCollectionView.children(matching: .cell).element(boundBy: 0).otherElements.containing(.image, identifier:"collectionViewCellImageView").element
        mainViewSmartHomeItemsCollectionViewCell.press(forDuration: 1.0)
        sleep(1)
    }
}
