//
//  SettingViewController.swift
//  LedBoard
//
//  Created by 김하은 on 2/1/25.
//

import UIKit

class SettingViewController: UIViewController {
    
    private let mainView = SettingsView()
    private var selectedColorButton: UIButton?
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let checkButton = UIBarButtonItem(
            image: UIImage(systemName: "checkmark"),
            style: .done,
            target: self,
            action: #selector(applyButtonTap)
        )
        
        navigationItem.rightBarButtonItem = checkButton
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.topItem?.title = nil
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        colorSetting()
        dataSetting()
    }
    
    func colorSetting() {
        ColorType.allCases.enumerated().forEach { index, colorType in
            let button = UIButton()
            button.backgroundColor = UIColor(named: colorType.rawValue)
            button.tag = index
            button.layer.cornerRadius = 5
            button.layer.borderWidth = 0
            button.layer.borderColor = UIColor.white.cgColor
            button.addTarget(self, action: #selector(selectColorButton(_:)), for: .touchUpInside)
            mainView.colorStackView.addArrangedSubview(button)
            
            button.snp.makeConstraints {
                $0.width.equalTo(button.snp.height)
            }
            
            if index == 0 {
                selectColorButton(button)
            }
        }
    }
    
    func dataSetting() {
        let settingData = SettingManager.shared.settingData
        
        mainView.messageField.text = settingData.text
        mainView.fontSizeSegment.selectedSegmentIndex = settingData.fontSizeIndex

        for button in mainView.colorStackView.arrangedSubviews.compactMap({ $0 as? UIButton }) {
            if button.tag == settingData.textColorIndex{
                selectColorButton(button)
                break
            }
        }
    }

    @objc func applyButtonTap() {
        let trimmedText = mainView.messageField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        let settingData = SettingData(
            text: trimmedText.isEmpty ? "화이팅!" : trimmedText,
            textColorIndex: selectedColorButton!.tag,
            fontSizeIndex: mainView.fontSizeSegment.selectedSegmentIndex
        )
        
        SettingManager.shared.settingData = settingData
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func selectColorButton(_ button: UIButton) {
        selectedColorButton?.layer.borderWidth = 0
        
        button.layer.borderWidth = 4
        button.layer.borderColor = UIColor.white.cgColor
        
        selectedColorButton = button
    }
}
