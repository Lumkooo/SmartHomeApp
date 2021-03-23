//
//  LampView.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/23/21.
//

import UIKit

protocol ILampView: AnyObject {

}

final class LampView: UIView, UITextViewDelegate {

    // MARK: - Views

    private lazy var customSlider: CustomSlider = {
        let myCustomSlider = CustomSlider()
        return myCustomSlider
    }()

    // MARK: - Properties

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        self.backgroundColor = .systemBackground
        self.setupElements()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ILampView

extension LampView: ILampView {

}

// MARK: - UISetup

private extension LampView {
    func setupElements() {
        self.setupCustomSlider()
    }

    func setupCustomSlider() {
        self.addSubview(self.customSlider)
        self.customSlider.translatesAutoresizingMaskIntoConstraints = false
        self.customSlider.delegate = self

        NSLayoutConstraint.activate([
            self.customSlider.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.customSlider.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.customSlider.widthAnchor.constraint(equalTo: self.widthAnchor),
            self.customSlider.heightAnchor.constraint(equalTo: self.heightAnchor),
        ])
    }
}

extension LampView: ICustomSlider {
    func sliderDidChangeValue(customSlider: CustomSlider, value: Int) {
        print("new Value is: ", value)
    }
}
