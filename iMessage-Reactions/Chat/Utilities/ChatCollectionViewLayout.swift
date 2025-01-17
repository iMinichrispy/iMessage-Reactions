//
//  ChatCollectionViewLayout.swift
//
//  Created by Alex Perez on 7/31/24.
//  Copyright © 2024 Alex Perez. All rights reserved.
//

import UIKit

final class ChatCollectionViewLayout: UICollectionViewCompositionalLayout {

    // MARK: - Initialization

    init() {
        super.init { sectionIndex, layoutEnvironment in
            Self.section(for: layoutEnvironment)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private

    private static func section(for layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(60.0))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, repeatingSubitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}
