//
//  MobileAds.swift
//  LedBoard
//
//  Created by 김하은 on 2/9/25.
//

import Foundation

final class MobileAds {
    static let shared = MobileAds()

    var bannerAdUnitID: String {
        #if DEBUG
            return "ca-app-pub-3940256099942544/2934735716"
        #else
            return "ca-app-pub-8834246592890399/7350194799"
        #endif
    }
}
