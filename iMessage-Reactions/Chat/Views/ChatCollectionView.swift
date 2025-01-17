//
//  ChatViewController.swift
//
//  Created by Alex Perez on 7/31/24.
//  Copyright © 2024 Alex Perez. All rights reserved.
//

import UIKit

final class ChatCollectionView: UICollectionView {

    // MARK: - Properties

    var accessoryProvider: ((IndexPath) -> ([Any]))?

    // MARK: - Initialization

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        register(MessageCell.self, forCellWithReuseIdentifier: String(describing: MessageCell.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UICollectionView

    /// Note: Must return `[_UIContextMenuAccessoryView]`
    override func contextMenuAccessories(for interaction: UIContextMenuInteraction, configuration: UIContextMenuConfiguration) -> [Any]? {
        guard let indexPath = configuration.identifier as? IndexPath else { return nil }

        return accessoryProvider?(indexPath)
    }

    /// Note: Must return `_UIContextMenuStyle`
    override func contextMenuStyle(for interaction: UIContextMenuInteraction, configuration: UIContextMenuConfiguration) -> Any? {
        let _UIContextMenuStyle = NSClassFromString("_UIContextMenuStyle") as! NSObject.Type

        let style = _UIContextMenuStyle.perform(NSSelectorFromString("defaultStyle")).takeUnretainedValue() as! NSObject

        let preferredEdgeInsets = UIEdgeInsets(top: 150.0, left: 30.0, bottom: 150.0, right: 30.0)
        style.setValue(preferredEdgeInsets, forKey: "preferredEdgeInsets")

        return style
    }
}
