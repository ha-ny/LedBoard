//
//  DisplayBoardViewController.swift
//  LedBoard
//
//  Created by 김하은 on 2023/07/25.
//

import UIKit

class DisplayBoardViewController: UIViewController {
    private let mainView = DisplayView()

    override func loadView() {
        super.loadView()
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(startScrollingAnimation),
                                               name: UIApplication.willEnterForegroundNotification,
                                               object: nil
        )
        
        mainView.settingButton.addTarget(self, action: #selector(settingButtonTap), for: .touchUpInside)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)

        updateText(settingData: SettingManager.shared.settingData)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopScrollingAnimation()
    }
    
    func updateText(settingData: SettingData) {
        let repeatedText = String(repeating:  settingData.text + " ", count: 10)
        mainView.displayLabel.text = repeatedText
        mainView.duplicateLabel.text = repeatedText
        mainView.displayLabel.font = .systemFont(ofSize: SettingData.calculateFontSize(segmentIndex: settingData.fontSizeIndex))
        mainView.duplicateLabel.font = .systemFont(ofSize: SettingData.calculateFontSize(segmentIndex: settingData.fontSizeIndex))
        mainView.displayLabel.textColor = UIColor(named: ColorType.allCases[settingData.textColorIndex].rawValue)!
        mainView.duplicateLabel.textColor = UIColor(named: ColorType.allCases[settingData.textColorIndex].rawValue)!

        mainView.displayLabel.sizeToFit()
        mainView.duplicateLabel.sizeToFit()
        
        let totalWidth = mainView.displayLabel.frame.width + 20
        mainView.textContainerView.snp.remakeConstraints {
            $0.height.equalToSuperview()
            $0.width.equalTo(totalWidth * 2)
        }
        
        startScrollingAnimation()
    }
    
    @objc func startScrollingAnimation() {
        let totalWidth = mainView.displayLabel.frame.width + 20
        mainView.textContainerView.transform = CGAffineTransform(translationX: 0, y: 0)
        
        let baseSpeed: CGFloat = 500 // 기준 속도 (200pt 당 1초)
        let duration = totalWidth / baseSpeed
        
        UIView.animate(withDuration: duration, delay: 0, options: [.repeat, .curveLinear], animations: {
            self.mainView.textContainerView.transform = CGAffineTransform(translationX: -totalWidth, y: 0)
        }, completion: nil)
    }
    
    func stopScrollingAnimation() {
        mainView.textContainerView.layer.removeAllAnimations()
        mainView.textContainerView.transform = CGAffineTransform(translationX: 0, y: 0)
    }
    
    @objc private func settingButtonTap() {
        let vc = SettingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
