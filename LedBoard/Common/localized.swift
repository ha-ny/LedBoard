//
//  localized.swift
//  LedBoard
//
//  Created by 김하은 on 2/4/25.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
