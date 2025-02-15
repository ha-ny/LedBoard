//
//  SettingViewController.swift
//  LedBoard
//
//  Created by 김하은 on 2/1/25.
//

import UIKit
import AVFoundation
import GoogleMobileAds

class SettingViewController: UIViewController, GADBannerViewDelegate {
    
    private let mainView = SettingsView()
    private var selectedColorButton: UIButton?
    
    private lazy var bannerView: GADBannerView = {
        let banner = GADBannerView(adSize: GADAdSizeBanner)
        banner.adUnitID = MobileAds.shared.bannerAdUnitID
        banner.rootViewController = self
        banner.load(GADRequest())
        return banner
    }()
    
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
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.setNavigationBarHidden(false, animated: false)

        mainView.messageField.delegate = self

          let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
          view.addGestureRecognizer(tapGesture)
        
        colorSetting()
        dataSetting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupBannerView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupBannerView()
        mainView.messageField.becomeFirstResponder()
    }
    
    private func setupBannerView() {
        mainView.bannerPlaceholderView.addSubview(bannerView)
        
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bannerView.leadingAnchor.constraint(equalTo: mainView.bannerPlaceholderView.leadingAnchor),
            bannerView.trailingAnchor.constraint(equalTo: mainView.bannerPlaceholderView.trailingAnchor),
            bannerView.topAnchor.constraint(equalTo: mainView.bannerPlaceholderView.topAnchor),
            bannerView.bottomAnchor.constraint(equalTo: mainView.bannerPlaceholderView.bottomAnchor)
        ])
        
        bannerView.load(GADRequest())
        bannerView.delegate = self
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
            text: trimmedText.isEmpty ? "place_supportMessage".localized : trimmedText,
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

extension SettingViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
              textField.selectAll(nil)
          }
      }

      @objc func dismissKeyboard() {
          view.endEditing(true)
      }
}
