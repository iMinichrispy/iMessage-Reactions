//
//  ChatCollectionViewDataSource.swift
//
//  Created by Alex Perez on 7/31/24.
//  Copyright © 2024 Alex Perez. All rights reserved.
//

import UIKit

final class ChatCollectionViewDataSource: NSObject, UICollectionViewDataSource {

    // MARK: - Propeties

    var messages: [Message] = []

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MessageCell.self), for: indexPath) as! MessageCell

        let message = messages[indexPath.item]
        cell.style = message.style
        cell.text = message.text

        return cell
    }
}
