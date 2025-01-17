//
//  MessageCell.swift
//
//  Created by Alex Perez on 7/31/24.
//  Copyright © 2024 Alex Perez. All rights reserved.
//

import UIKit

final class MessageCell: UICollectionViewCell {

    // MARK: - Constants

    private enum Constants {
        static let bubbleCornerRadius = 20.0
    }

    // MARK: - Properties

    var style: MessageStyle = .sending {
        didSet {
            guard style != oldValue else { return }
            updateColors(for: style)
            updateHorizontalConstraint(for: style)
        }
    }

    var text: String? {
        didSet {
            textLabel.text = text
        }
    }

    var backgroundCornerCurve: UIBezierPath {
        return UIBezierPath(roundedRect: roundedBackgroundView.bounds, cornerRadius: Constants.bubbleCornerRadius)
    }

    private let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        return label
    }()

    let roundedBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = Constants.bubbleCornerRadius
        view.layer.cornerCurve = .continuous
        view.clipsToBounds = true
        return view
    }()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        build()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UICollectionViewCell

    override func prepareForReuse() {
        super.prepareForReuse()
        text = nil
    }

    // MARK: - Private

    private func build() {
        roundedBackgroundView.addSubview(textLabel)
        contentView.addSubview(roundedBackgroundView)

        updateColors(for: style)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            roundedBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
            roundedBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0),
        ])

        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: roundedBackgroundView.topAnchor, constant: 10.0),
            textLabel.bottomAnchor.constraint(equalTo: roundedBackgroundView.bottomAnchor, constant: -10.0),
            textLabel.leadingAnchor.constraint(equalTo: roundedBackgroundView.leadingAnchor, constant: 12.0),
            textLabel.trailingAnchor.constraint(equalTo: roundedBackgroundView.trailingAnchor, constant: -12.0),
        ])

        updateHorizontalConstraint(for: style)
    }

    private func updateColors(for style: MessageStyle) {
        textLabel.textColor = switch style {
        case .sending:
            .white
        case .receiving:
            .label
        }

        roundedBackgroundView.backgroundColor = switch style {
        case .sending:
            .systemBlue
        case .receiving:
            .systemGray6
        }
    }

    private var currentHorizontalConstraints: [NSLayoutConstraint] = []
    private func updateHorizontalConstraint(for style: MessageStyle) {
        let horizontalConstraints = switch style {
        case .sending:
            [
                roundedBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
                roundedBackgroundView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.centerXAnchor),
            ]
        case .receiving:
            [
                roundedBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
                roundedBackgroundView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.centerXAnchor),
            ]
        }

        NSLayoutConstraint.deactivate(currentHorizontalConstraints)
        NSLayoutConstraint.activate(horizontalConstraints)
        currentHorizontalConstraints = horizontalConstraints
    }
}
