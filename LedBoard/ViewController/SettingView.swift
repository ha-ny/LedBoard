//
//  SettingView.swift
//  LedBoard
//
//  Created by 김하은 on 2/1/25.
//

import UIKit

final class SettingsView: UIView {
    
    let messageField: UITextField = {
        let view = UITextField()
        view.borderStyle = .none
        view.placeholder = "place_supportMessage".localized
        view.font = .systemFont(ofSize: 15)
        view.backgroundColor = .black
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        view.layer.cornerRadius = 8.0
        view.tintColor = .gray
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50)) // height 명시적으로 설정
        view.leftView = paddingView
        view.rightView = paddingView
        view.leftViewMode = .always
        view.rightViewMode = .always
        
        return view
    }()
    
    let fontSizeSegment = {
        let view = UISegmentedControl(items: ["font_Small".localized, "font_Medium".localized, "font_Large".localized])
        view.selectedSegmentIndex = 1
        return view
    }()
    
    let colorStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.distribution = .fillEqually
        return view
    }()

    let bannerPlaceholderView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        addView()
        addMakeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addView() {
        addSubview(messageField)
        addSubview(fontSizeSegment)
        addSubview(colorStackView)
        addSubview(bannerPlaceholderView)
    }
    
    func addMakeConstraints() {
        messageField.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(14)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(30)
            make.width.equalToSuperview().multipliedBy(0.6).offset(-45)
            make.height.equalTo(50)
        }

        fontSizeSegment.snp.makeConstraints { make in
            make.top.equalTo(messageField)
            make.leading.equalTo(messageField.snp.trailing).offset(30)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-30)
            make.height.equalTo(50)
        }
        
        colorStackView.snp.makeConstraints {
            $0.top.equalTo(fontSizeSegment.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        bannerPlaceholderView.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.height.equalTo(45)
        }
    }
}
