//
//  ColorItemCollectionViewCell.swift
//  Smart Home App
//
//  Created by Андрей Шамин on 3/26/21.
//

import UIKit

final class ColorItemCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties

    static let reuseIdentifier = String(describing: self)
    private(set) var color: UIColor? {
        didSet {
            self.backgroundColor = self.color
        }
    }

    // MARK: - Views

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - layoutSubviews

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.width/2
    }


    // MARK: - Public method

    func setupCell(color: UIColor) {
        self.color = color
    }
}
