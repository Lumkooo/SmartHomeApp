//
//  ColorChooserView.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/26/21.
//

import UIKit

protocol IColorChooserView: AnyObject {
    var cellTappedAt: ((IndexPath) -> Void)? { get set }
    var dismissView : (() -> Void)? { get set }

    func setupView(colors: [UIColor])
    func prepareViewToClose(closure:  @escaping (() -> Void))
}

final class ColorChooserView: UIView {

    // MARK: - Constants

    private enum Constants {
        static let alphaMultiplier: CGFloat = 0.3
        static let containerViewWidthMultiplier: CGFloat = 0.75
        static let containerViewHeightMultiplier: CGFloat = 0.4
        static let colorLabelFont = UIFont.systemFont(ofSize: 23, weight: .semibold)
        static let animationDuration: Double = 0.5
        static let collectionViewItemWidth: CGFloat = 0.3
    }

    // MARK: - Views

    private lazy var containerView: UIView = {
        let myView = UIView()
        myView.backgroundColor = .lightGray
        myView.layer.cornerRadius = AppConstants.Sizes.cornerRadius
        myView.clipsToBounds = true
        return myView
    }()

    private lazy var colorLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.font = Constants.colorLabelFont
        myLabel.textAlignment = .center
        myLabel.textColor = .white
        myLabel.text = "Выберете цвет свечения лампы:"
        myLabel.numberOfLines = 0
        return myLabel
    }()

    private lazy var closeButton: UIButton = {
        let myButton = UIButton()
        myButton.setImage(AppConstants.Images.xmark, for: .normal)
        myButton.tintColor = .black
        myButton.backgroundColor = .clear
        myButton.addTarget(self,
                           action: #selector(self.handleTap(_:)),
                           for: .touchUpInside)
        return myButton
    }()

    private lazy var collectionView: UICollectionView = {
        let myCollectionView:UICollectionView = UICollectionView(
            frame: CGRect.zero,
            collectionViewLayout: UICollectionViewFlowLayout.init())
        myCollectionView.register(ColorItemCollectionViewCell.self,
                                  forCellWithReuseIdentifier: ColorItemCollectionViewCell.reuseIdentifier)
        return myCollectionView
    }()

    // MARK: - Properties

    var cellTappedAt: ((IndexPath) -> Void)?
    var dismissView : (() -> Void)?
    private var collectionViewDataSource = ColorItemCollectionViewDataSource()
    private var collectionViewDelegate: ColorItemCollectionViewDelegate?

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        self.backgroundColor = UIColor.black.withAlphaComponent(Constants.alphaMultiplier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        self.dismissView?()
    }

    // MARK: - layoutSubviews

    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = self.setupCollectionViewLayout()
        self.collectionView.setCollectionViewLayout(layout, animated: true)
    }
}

// MARK: - IColorChooserView

extension ColorChooserView: IColorChooserView {
    func setupView(colors: [UIColor]) {
        self.setupElements()
        self.collectionViewDataSource.setData(colors: colors)
        self.collectionView.reloadData()
    }

    func prepareViewToClose(closure: @escaping (() -> Void)) {

        UIView.animate(withDuration: Constants.animationDuration) {
            let translationY: CGFloat = 1000
            self.containerView.transform = CGAffineTransform(translationX: 0,
                                                             y: translationY)
        } completion: { _ in
            closure()
        }
    }
}

// MARK: - UISetup

private extension ColorChooserView {
    func setupElements() {
        self.setupContainerView()
    }

    func setupContainerView() {
        self.addSubview(self.containerView)
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.containerView.widthAnchor.constraint(equalTo: self.widthAnchor,
                                                      multiplier: Constants.containerViewWidthMultiplier),
            self.containerView.heightAnchor.constraint(equalTo: self.heightAnchor,
                                                       multiplier: Constants.containerViewHeightMultiplier)
        ])

        self.setupCloseButton()
        self.setupColorLabel()
        self.setupCollectionView()
    }

    func setupCloseButton() {
        self.containerView.addSubview(self.closeButton)
        self.closeButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.closeButton.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor,
                                                     constant: -AppConstants.Constraints.half),
            self.closeButton.topAnchor.constraint(equalTo: self.containerView.topAnchor,
                                                 constant: AppConstants.Constraints.half)
        ])
    }

    func setupColorLabel() {
        self.containerView.addSubview(self.colorLabel)
        self.colorLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.colorLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor,
                                                     constant: AppConstants.Constraints.half),
            self.colorLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor,
                                                     constant: -AppConstants.Constraints.half),
            self.colorLabel.topAnchor.constraint(equalTo: self.closeButton.bottomAnchor,
                                                 constant: AppConstants.Constraints.half)
        ])
    }
}


// MARK: - CollectionView setup

private extension ColorChooserView {
    func setupCollectionView() {
        self.collectionViewDelegate = ColorItemCollectionViewDelegate(withDelegate: self)
        self.collectionView.delegate = self.collectionViewDelegate
        self.collectionView.dataSource = self.collectionViewDataSource
        self.collectionView.backgroundColor = .clear

        self.containerView.addSubview(self.collectionView)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.colorLabel.bottomAnchor,
                                                     constant: AppConstants.Constraints.half),
            self.collectionView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor)
        ])
    }

    func setupCollectionViewLayout() -> UICollectionViewFlowLayout {
        // Ширина ячейки равна ширине экрана, поделенная на два минус места для отступа ячеек
        // друг от друга
        let itemWidth = self.containerView.frame.width * Constants.collectionViewItemWidth
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        // Высота ячейки равна ширине, умноженной на константу
        layout.itemSize = CGSize(width: itemWidth,
                                 height: itemWidth)
        layout.sectionInset = UIEdgeInsets(top: AppConstants.Constraints.normal,
                                           left: AppConstants.Constraints.normal,
                                           bottom: AppConstants.Constraints.normal,
                                           right: AppConstants.Constraints.normal)
        layout.minimumLineSpacing = AppConstants.Constraints.normal
        return layout
    }
}

// MARK: - ICustomCollectionViewDelegate

extension ColorChooserView: ICustomCollectionViewDelegate {
    func didSelectItemAt(indexPath: IndexPath) {
        self.cellTappedAt?(indexPath)
    }
}
