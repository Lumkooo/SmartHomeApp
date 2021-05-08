//
//  SendErrorView.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 5/8/21.
//

import UIKit

protocol ISendErrorView: AnyObject {
    var doneButtonTappedWith: ((String) -> Void)? { get set }
}

final class SendErrorView: UIView {

    // MARK: - Views

    private lazy var errorTextView: UITextView = {
        let myTextView = UITextView()
        myTextView.tintColor = myTextView.textColor
        myTextView.font = AppConstants.Fonts.deviceLabel
        myTextView.backgroundColor = .clear
        myTextView.textContainerInset = UIEdgeInsets(top: 8,
                                                     left: 16,
                                                     bottom: 0,
                                                     right: 16)
        myTextView.text = Localized("SendErrorPlaceholder")
        myTextView.textColor = UIColor.lightGray
        myTextView.delegate = self
        return myTextView
    }()

    private lazy var errorTextViewBackgroundView: UIView = {
        let myView = UIView()
        myView.backgroundColor = .label
        return myView
    }()

    private let doneButton: CustomButton = {
        let button = CustomButton()
        button.setTitle(Localized("done"), for: .normal)
        button.addTarget(self,
                         action: #selector(doneButtonTapped(gesture:)),
                         for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Properties

    private var isKeyboardShowing = false
    private var doneButtonBottomAnchor: NSLayoutConstraint!
    private var doneButtonBottomAnchorWithKeyboard: NSLayoutConstraint!
    var doneButtonTappedWith: ((String) -> Void)?

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        self.setupElements()
        self.setupNotifications()
        self.backgroundColor = .systemBackground
        self.setupTapToHideKeyboard()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.errorTextViewBackgroundView.roundCorners(corners: [.bottomLeft, .bottomRight],
                                                      radius: AppConstants.Sizes.cornerRadius)
    }

    // MARK: - Обработка нажатий на кнопки

    @objc private func doneButtonTapped(gesture: UIGestureRecognizer) {
        guard let text = self.errorTextView.text else {
            return
        }
        let trimmedString = text.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmedString.isEmpty {
            self.doneButtonTappedWith?(trimmedString)
        }
    }
}

// MARK: - ISendErrorView

extension SendErrorView: ISendErrorView {

}

// MARK: - UISetup

private extension SendErrorView {
    func setupElements() {
        self.setupDoneButtonAnchor()
        self.setupErrorTextViewBackgroundView()
        self.setupDoneButton()
    }

    func setupDoneButtonAnchor() {
        self.doneButtonBottomAnchor = self.doneButton.bottomAnchor.constraint(
            equalTo: self.safeAreaLayoutGuide.bottomAnchor,
            constant: -AppConstants.Constraints.normal)
    }

    func setupErrorTextViewBackgroundView() {
        self.addSubview(self.errorTextViewBackgroundView)
        self.errorTextViewBackgroundView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.errorTextViewBackgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.errorTextViewBackgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.errorTextViewBackgroundView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.errorTextViewBackgroundView.heightAnchor.constraint(equalTo: self.heightAnchor,
                                                                     multiplier: 0.3)
        ])
        self.setupErrorTextView()
    }

    func setupErrorTextView() {
        self.errorTextViewBackgroundView.addSubview(self.errorTextView)
        self.errorTextView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.errorTextView.leadingAnchor.constraint(equalTo: errorTextViewBackgroundView.leadingAnchor),
            self.errorTextView.trailingAnchor.constraint(equalTo: errorTextViewBackgroundView.trailingAnchor),
            self.errorTextView.topAnchor.constraint(equalTo: errorTextViewBackgroundView.topAnchor),
            self.errorTextView.bottomAnchor.constraint(equalTo: errorTextViewBackgroundView.bottomAnchor)
        ])
    }

    func setupDoneButton() {
        self.addSubview(self.doneButton)
        self.doneButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.doneButton.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                     constant: AppConstants.Constraints.normal),
            self.doneButtonBottomAnchor,
            self.doneButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                      constant: -AppConstants.Constraints.normal),
            self.doneButton.heightAnchor.constraint(equalToConstant: AppConstants.Sizes.closeButtonSize.height)
        ])
    }

    func setupTapToHideKeyboard() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(dismissKeyboard))
        self.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        self.endEditing(true)
    }
}

// MARK: - Работа с клавиатурой

private extension SendErrorView {
    func setupNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name:UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name:UIResponder.keyboardWillHideNotification,
            object: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if !self.isKeyboardShowing {
            if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                let keyboardHeight = keyboardRectangle.height
                let anchorConstant = keyboardHeight - self.safeAreaInsets.bottom
                self.doneButtonBottomAnchorWithKeyboard = self.doneButton.bottomAnchor.constraint(
                    equalTo: self.safeAreaLayoutGuide.bottomAnchor,
                    constant: -anchorConstant)
                NSLayoutConstraint.deactivate([self.doneButtonBottomAnchor])
                NSLayoutConstraint.activate([self.doneButtonBottomAnchorWithKeyboard])
                UIView.animate(withDuration: AppConstants.AnimationTime.keyboardAnimationDuration) {
                    self.layoutIfNeeded()
                }
                self.isKeyboardShowing = true
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.isKeyboardShowing {
            NSLayoutConstraint.deactivate([self.doneButtonBottomAnchorWithKeyboard])
            NSLayoutConstraint.activate([self.doneButtonBottomAnchor])
            UIView.animate(withDuration: AppConstants.AnimationTime.keyboardAnimationDuration) {
                self.layoutIfNeeded()
            }
            self.isKeyboardShowing = false
        }
    }
}

extension SendErrorView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = .systemBackground
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        guard let text = textView.text else {
            return
        }
        let trimmedString = text.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedString.isEmpty {
            textView.text = Localized("SendErrorPlaceholder")
            textView.textColor = UIColor.lightGray
        }
    }
}
