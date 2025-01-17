//
//  Message.swift
//
//  Created by Alex Perez on 7/31/24.
//  Copyright © 2024 Alex Perez. All rights reserved.
//

import Foundation

enum MessageStyle {
    case sending
    case receiving
}

struct Message {
    let style: MessageStyle
    let text: String
}
