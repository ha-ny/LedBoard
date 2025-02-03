//
//  DisplayView.swift
//  LedBoard
//
//  Created by 김하은 on 2/1/25.
//

import UIKit
import SnapKit

final class DisplayView: UIView {
    
    let scrollView = {
        let view = UIScrollView()
        view.showsHorizontalScrollIndicator = false
        view.isUserInteractionEnabled = false
        view.clipsToBounds = true
        return view
    }()
    
    let textContainerView = UIView()
    
    let displayLabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.lineBreakMode = .byClipping
        view.textAlignment = .left
        return view
    }()
    
    let duplicateLabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.lineBreakMode = .byClipping
        view.textAlignment = .left
        return view
    }()
    
    let settingButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "icon_Brush"), for: .normal)
        view.setImage(UIImage(named: "icon_Brush"), for: .highlighted)
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
        addSubview(scrollView)
        scrollView.addSubview(textContainerView)
        textContainerView.addSubview(displayLabel)
        textContainerView.addSubview(duplicateLabel)
        addSubview(settingButton)
    }
    
    private func addMakeConstraints() {
        scrollView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.edges.equalToSuperview()
        }
        
        textContainerView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.edges.equalToSuperview()
        }
        
        displayLabel.snp.makeConstraints {
            $0.left.centerY.equalToSuperview()
        }

        duplicateLabel.snp.makeConstraints {
            $0.left.equalTo(displayLabel.snp.right).offset(20)
            $0.centerY.equalToSuperview()
        }

        settingButton.snp.makeConstraints {
            $0.top.right.equalTo(self.safeAreaLayoutGuide).inset(30)
            $0.size.equalTo(30)
        }
    }
}
