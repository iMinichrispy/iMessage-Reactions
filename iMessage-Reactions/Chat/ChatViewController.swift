//
//  ChatViewController.swift
//
//  Created by Alex Perez on 7/31/24.
//  Copyright © 2024 Alex Perez. All rights reserved.
//

import iMessageUI
import UIKit

final class ChatViewController: UICollectionViewController {

    // MARK: - Properties
    
    private var conversation: Conversation? {
        didSet {
            dataSource.messages = conversation?.messages ?? []
            collectionView.reloadData()
        }
    }

    private var dataSource = ChatCollectionViewDataSource()
    private lazy var chatCollectionView = ChatCollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)

    // MARK: - Initialization

    init() {
        super.init(collectionViewLayout: ChatCollectionViewLayout())
        title = "Messages"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController

    override func loadView() {
        collectionView = chatCollectionView
        collectionView.dataSource = dataSource
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        chatCollectionView.accessoryProvider = { [weak self] indexPath in
            guard let message = self?.dataSource.messages[indexPath.item] else { return [] }

            let alignment: UIContextMenuAccessoryAlignment = switch message.style {
            case .sending:
                .trailing
            case .receiving:
                .leading
            }

            let accessoryView = _UIContextMenuAccessoryViewBuilder.build(with: alignment, offset: .zero)
            accessoryView?.frame = CGRect(x: 0, y: 0, width: 280, height: 70)
            accessoryView?.backgroundColor = .systemFill
            accessoryView?.layer.cornerCurve = .continuous
            accessoryView?.layer.cornerRadius = 10

            guard let accessoryView else { return [] }
            return [accessoryView]
        }

        dataSource.messages = [
            Message(style: .receiving, text: "This is a longer potentially multiline message that is long"),
            Message(style: .receiving, text: "text 2"),
            Message(style: .receiving, text: "AAAAAAAAA AAAAAA AAAAA AAAAAAA"),
            Message(style: .sending, text: "text 4"),
            Message(style: .sending, text: "😊🥰😛"),
            Message(style: .receiving, text: "text 3"),
        ]
        collectionView.reloadData()
    }

    override func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemsAt indexPaths: [IndexPath], point: CGPoint) -> UIContextMenuConfiguration? {
        guard let indexPath = indexPaths.first else { return nil }

        let section1 = UIMenu(options: .displayInline, children: [
            UIAction(title: "Reply", image: UIImage(systemName: "arrowshape.turn.up.left"), handler: { _ in }),
        ])

        let section2 = UIMenu(options: .displayInline, children: [
            UIAction(title: "Copy", image: UIImage(systemName: "doc.on.doc"), handler: { _ in }),
            UIAction(title: "Translate", image: UIImage(systemName: "translate"), handler: { _ in }),
            UIAction(title: "More...", image: UIImage(systemName: "ellipsis.circle"), handler: { _ in }),
        ])

        return UIContextMenuConfiguration(identifier: indexPath as NSIndexPath, actionProvider: { _ in
            UIMenu(children: [section1, section2])
        })
    }

    override func collectionView(_ collectionView: UICollectionView, contextMenuConfiguration configuration: UIContextMenuConfiguration, highlightPreviewForItemAt indexPath: IndexPath) -> UITargetedPreview? {
        return targetedPreview(for: indexPath)
    }

    override func collectionView(_ collectionView: UICollectionView, contextMenuConfiguration configuration: UIContextMenuConfiguration, dismissalPreviewForItemAt indexPath: IndexPath) -> UITargetedPreview? {
        return targetedPreview(for: indexPath)
    }

    // MARK: - Private

    private func targetedPreview(for indexPath: IndexPath) -> UITargetedPreview? {
        guard let cell = collectionView.cellForItem(at: indexPath) as? MessageCell else { return nil }

        let parameters = UIPreviewParameters()
        parameters.visiblePath = cell.backgroundCornerCurve

        let targetedPreview = UITargetedPreview(view: cell.roundedBackgroundView, parameters: parameters)
        return targetedPreview
    }
}
