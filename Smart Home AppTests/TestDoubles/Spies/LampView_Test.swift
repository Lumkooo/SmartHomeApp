//
//  LampView_Test.swift
//  Smart Home AppTests
//
//  Created by Андрей Шамин on 5/22/21.
//

import Foundation
import UIKit
@testable import Smart_Home_App

class LampView_Test: ILampView {

    // MARK: - Properties

    var toggleLamp: (() -> Void)?
    var sliderDidChangeValue: ((Int) -> Void)?
    var sliderDidEndGesture: ((Int) -> Void)?
    var colorChangeButtonPressed: (() -> Void)?

    private(set) var isViewPreparedForLamp = false
    private(set) var isLampInfoChangedOnView = false
    private(set) var isLightColorChanged = false
    private(set) var isLightLevelChanged = false

    // MARK: - Public methods

    func prepareView(lamp: Lamp) {
        self.isViewPreparedForLamp = true
    }

    func changeLampInfo(lamp: Lamp) {
        self.isLampInfoChangedOnView = true
    }

    func changeLightColorTo(_ color: UIColor) {
        self.isLightColorChanged = true
    }

    func changeLightLevelTo(_ level: Int) {
        self.isLightLevelChanged = true
    }
}
