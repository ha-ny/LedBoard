//
//  SettingManager.swift
//  LedBoard
//
//  Created by 김하은 on 2/1/25.
//

import UIKit

/// 설정 데이터 구조체
struct SettingData {
    let text: String
    let textColorIndex: Int
    let fontSizeIndex: Int
    
    static func calculateFontSize(segmentIndex: Int) -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        
        switch segmentIndex {
        case 0: return screenHeight / 3   // 작게 (화면 높이의 1/3)
        case 1: return screenHeight / 2   // 중간 (화면 높이의 1/2)
        case 2: return screenHeight * 2 / 3 // 크게 (화면 높이의 2/3)
        default: return screenHeight / 2
        }
    }
}

class SettingManager {
    static let shared = SettingManager()
    
    private static let settingKey = "SettingData"
    
    var settingData: SettingData {
        didSet {
            saveSettings()
        }
    }
    
    private init() {
        if let savedData = SettingManager.loadSettings() {
            settingData = savedData
        } else {
            settingData = SettingData(
                text: "onboardMessage".localized,
                textColorIndex: 2,
                fontSizeIndex: 0
            )
            saveSettings() // 기본값 저장
        }
    }

    /// 설정값 저장
    private func saveSettings() {
        let data: [String: Any] = [
            "text": settingData.text,
            "textColorIndex": settingData.textColorIndex,
            "fontSizeIndex": settingData.fontSizeIndex
        ]
        
        UserDefaults.standard.set(data, forKey: SettingManager.settingKey)
    }

    /// 저장된 설정값 불러오기
    private static func loadSettings() -> SettingData? {
        guard let data = UserDefaults.standard.dictionary(forKey: settingKey),
              let text = data["text"] as? String,
              let textColorIndex = data["textColorIndex"] as? Int,
              let fontSizeIndex = data["fontSizeIndex"] as? Int else { return nil }

        return SettingData(text: text, textColorIndex: textColorIndex, fontSizeIndex: fontSizeIndex)
    }
}
