//
//  AddDeviceView.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 4/25/21.
//

import UIKit

protocol IAddDeviceView: AnyObject {
    var codeError: (() -> Void)? { get set }
    var nameError: (() -> Void)? { get set }
    var save: ((_ name: String, _ code: String) -> Void)? { get set }
}

final class AddDeviceView: UIView {

    // MARK: - Views

    private lazy var deviceCodeLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.font = AppConstants.Fonts.titleLabelFont
        myLabel.numberOfLines = 2
        myLabel.text = Localized("deviceCodeText")
        return myLabel
    }()

    private lazy var deviceCodeTextField: UITextField = {
        let myTextField = UITextField()
        myTextField.font = AppConstants.Fonts.titleLabelFont
        myTextField.placeholder = Localized("code")
        myTextField.borderStyle = .roundedRect
//        myTextField.borderStyle = .roundedRect
        return myTextField
    }()

    private lazy var deviceNameLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.font = AppConstants.Fonts.titleLabelFont
        myLabel.numberOfLines = 2
        myLabel.text = Localized("deviceNameText")
        return myLabel
    }()

    private lazy var deviceNameTextField: UITextField = {
        let myTextField = UITextField()
        myTextField.font = AppConstants.Fonts.titleLabelFont
        myTextField.placeholder = Localized("name")
        myTextField.borderStyle = .roundedRect
        return myTextField
    }()

    private lazy var saveButton: CustomButton = {
        let myButton = CustomButton()
        myButton.titleLabel?.font = AppConstants.Fonts.titleLabelFont
        myButton.setTitle(Localized("save"), for: .normal)
        myButton.addTarget(self,
                           action: #selector(saveButtonTapped(gesture:)),
                           for: .touchUpInside)
        return myButton
    }()

    // MARK: - Properties

    var codeError: (() -> Void)?
    var nameError: (() -> Void)?
    var save: ((_ name: String, _ code: String) -> Void)?

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        self.backgroundColor = .systemBackground
        self.setupElements()
        self.setupTapToClose()
        self.setupDelegates()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - IAddDeviceView

extension AddDeviceView: IAddDeviceView {

}

// MARK: - UISetup

private extension AddDeviceView {
    func setupElements() {
        self.setupDeviceCodeLabel()
        self.setupDeviceCodeTextField()
        self.setupDeviceNameLabel()
        self.setupDeviceNameTextField()
        self.setupSaveButton()
    }

    func setupDeviceCodeLabel() {
        self.addSubview(self.deviceCodeLabel)
        self.deviceCodeLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.deviceCodeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                          constant: AppConstants.Constraints.normal),
            self.deviceCodeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                          constant: -AppConstants.Constraints.normal),
            self.deviceCodeLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,
                                                          constant: AppConstants.Constraints.normal)
        ])
    }

    func setupDeviceCodeTextField() {
        self.addSubview(self.deviceCodeTextField)
        self.deviceCodeTextField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.deviceCodeTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                              constant: AppConstants.Constraints.normal),
            self.deviceCodeTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                              constant: -AppConstants.Constraints.normal),
            self.deviceCodeTextField.topAnchor.constraint(equalTo: self.deviceCodeLabel.bottomAnchor,
                                                              constant: AppConstants.Constraints.half)
        ])
    }

    func setupDeviceNameLabel() {
        self.addSubview(self.deviceNameLabel)
        self.deviceNameLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.deviceNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                          constant: AppConstants.Constraints.normal),
            self.deviceNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                          constant: -AppConstants.Constraints.normal),
            self.deviceNameLabel.topAnchor.constraint(equalTo: self.deviceCodeTextField.bottomAnchor,
                                                          constant: AppConstants.Constraints.normal)
        ])
    }

    func setupDeviceNameTextField() {
        self.addSubview(self.deviceNameTextField)
        self.deviceNameTextField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.deviceNameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                              constant: AppConstants.Constraints.normal),
            self.deviceNameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                              constant: -AppConstants.Constraints.normal),
            self.deviceNameTextField.topAnchor.constraint(equalTo: self.deviceNameLabel.bottomAnchor,
                                                              constant: AppConstants.Constraints.half)
        ])
    }

    func setupSaveButton() {
        self.addSubview(self.saveButton)
        self.saveButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.saveButton.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                     constant: AppConstants.Constraints.normal),
            self.saveButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                     constant: -AppConstants.Constraints.normal),
            self.saveButton.topAnchor.constraint(equalTo: self.deviceNameTextField.bottomAnchor,
                                                 constant: AppConstants.Constraints.twice),
            self.saveButton.heightAnchor.constraint(equalToConstant: AppConstants.Sizes.closeButtonSize.height)
        ])
    }
}

// MARK: - Private

private extension AddDeviceView {
    func setupTapToClose() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(UIInputViewController.dismissKeyboard))
        self.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        self.endEditing(true)
    }

    func setupDelegates() {
        self.deviceCodeTextField.delegate = self
        self.deviceNameTextField.delegate = self
    }

    func addDevice() {
        guard let code = self.deviceCodeTextField.text,
              code.count == 11 else {
            self.codeError?()
            return
        }

        guard let name = self.deviceNameTextField.text,
              name.count <= 15,
              !name.isEmpty else {
            self.nameError?()
            return
        }
        self.dismissKeyboard()
        self.save?(name, code)
        self.saveButton.isEnabled = false
    }

    @objc func saveButtonTapped(gesture: UIGestureRecognizer) {
        self.addDevice()
    }
}

extension AddDeviceView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.deviceCodeTextField {
            self.deviceCodeTextField.resignFirstResponder()
            self.deviceNameTextField.becomeFirstResponder()
        } else if textField == deviceNameTextField {
            self.deviceNameTextField.resignFirstResponder()
            self.addDevice()
        }
        return true
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = self.deviceCodeTextField.text else { return }
        self.deviceCodeTextField.text = text.applyPatternOnNumbers(pattern: "###-###-###", replacmentCharacter: "#")
    }

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if textField == deviceCodeTextField {
            let charsLimit = 11
            let startingLength = textField.text?.count ?? 0
            let lengthToAdd = string.count
            let lengthToReplace =  range.length
            let newLength = startingLength + lengthToAdd - lengthToReplace
            return newLength <= charsLimit
        } else {
            let charsLimit = 20
            let startingLength = textField.text?.count ?? 0
            let lengthToAdd = string.count
            let lengthToReplace =  range.length
            let newLength = startingLength + lengthToAdd - lengthToReplace
            return newLength <= charsLimit
        }
    }
}
