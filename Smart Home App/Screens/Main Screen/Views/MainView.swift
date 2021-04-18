//
//  MainView.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/21/21.
//

import UIKit

protocol IMainView: AnyObject {
    var goToDeviceAt: ((IndexPath) -> Void)? { get set }
    var toggleLikedState: ((IndexPath) -> Void)? { get set }
    var cellTappedAt: ((IndexPath) -> Void)? { get set }

    func reloadView(devices: [SmartHomeDevice])
    func moveCollectionViewOnLeft()
    func moveContentBackAfterMenu()
}

final class MainView: UIView {

    // MARK: - Constants

    private enum Constants {
        static let collectionViewCellHeightMultiplier: CGFloat = 1.25
    }

    // MARK: - Views

    private lazy var collectionView: UICollectionView = {
        let myCollectionView:UICollectionView = UICollectionView(
            frame: CGRect.zero,
            collectionViewLayout: UICollectionViewFlowLayout.init())
        myCollectionView.register(SmartHomeDeviceCollectionViewCell.self,
                                  forCellWithReuseIdentifier: SmartHomeDeviceCollectionViewCell.reuseIdentifier)
        myCollectionView.accessibilityIdentifier = "MainViewSmartHomeItemsCollectionView"
        return myCollectionView
    }()
    
    // MARK: - Properties

    private var collectionViewDataSource = SmartHomeItemCollectionViewDataSource()
    private var collectionViewDelegate: SmartHomeItemCollectionViewDelegate?
    var goToDeviceAt: ((IndexPath) -> Void)?
    var cellTappedAt: ((IndexPath) -> Void)?
    var toggleLikedState: ((IndexPath) -> Void)?

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        self.backgroundColor = .systemBackground
        self.setupElements()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - layoutSubviews

    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = self.setupCollectionViewLayout()
        self.collectionView.setCollectionViewLayout(layout, animated: true)
    }
}

// MARK: - IMainView

extension MainView: IMainView {
    func reloadView(devices: [SmartHomeDevice]) {
        self.collectionViewDataSource.setData(devices: devices)
        self.collectionViewDelegate?.setData(devices: devices)
        self.collectionView.reloadData()
    }
    
    func moveCollectionViewOnLeft() {
        UIView.animate(withDuration: AppConstants.AnimationTime.menuAnimationTime) {
            self.collectionView.transform = CGAffineTransform(
                translationX: -self.frame.width * AppConstants.Sizes.menuWidth,
                y: 0)
        }
    }
    
    func moveContentBackAfterMenu() {
        UIView.animate(withDuration: AppConstants.AnimationTime.menuAnimationTime) {
            self.collectionView.transform = CGAffineTransform(
                translationX: 0,
                y: 0)
        }
    }
}

// MARK: - UISetup

private extension MainView {
    func setupElements() {
        self.setupCollectionView()
    }

    func setupCollectionView() {
        self.collectionViewDelegate = SmartHomeItemCollectionViewDelegate(withDelegate: self)
        self.collectionView.delegate = self.collectionViewDelegate
        self.collectionView.dataSource = self.collectionViewDataSource
        self.collectionView.backgroundColor = .clear

        self.addSubview(self.collectionView)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(
                equalTo: self.topAnchor,
                constant: AppConstants.Constraints.normal),
            self.collectionView.leadingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(
                equalTo: self.bottomAnchor)
        ])
    }

    func setupCollectionViewLayout() -> UICollectionViewFlowLayout {
        // Ширина ячейки равна ширине экрана, поделенная на два минус места для отступа ячеек
        // друг от друга
        let itemWidth = self.frame.width / 2 - 1.5 * AppConstants.Constraints.normal
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        // Высота ячейки равна ширине, умноженной на константу
        layout.itemSize = CGSize(width: itemWidth,
                                 height: Constants.collectionViewCellHeightMultiplier * itemWidth)
        layout.sectionInset = UIEdgeInsets(top: AppConstants.Constraints.normal,
                                           left: AppConstants.Constraints.normal,
                                           bottom: AppConstants.Constraints.normal,
                                           right: AppConstants.Constraints.normal)
        layout.minimumLineSpacing = AppConstants.Constraints.normal
        return layout
    }
}

// MARK: - IImagesCollectionViewDelegate

extension MainView: IImagesCollectionViewDelegate {
    func toggleLikedState(atIndexPath indexPath: IndexPath) {
        self.toggleLikedState?(indexPath)
    }

    func goToDevice(atIndexPath indexPath: IndexPath) {
        self.goToDeviceAt?(indexPath)
    }
}

// MARK: - ICustomCollectionViewDelegate

extension MainView: ICustomCollectionViewDelegate {
    func didSelectItemAt(indexPath: IndexPath) {
        self.cellTappedAt?(indexPath)
    }
}
