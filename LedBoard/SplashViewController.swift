//
//  SplashViewController.swift
//  LedBoard
//
//  Created by 김하은 on 2/4/25.
//

import UIKit

final class SplashViewController: UIViewController {
    
    private let imageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Splash_LED")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        startImageAnimation()
    }
    
    private func startImageAnimation() {
        let interval = 0.28
        var index = 0
        let imageNames = ["Splash_LED", "Splash_L", "Splash_LE", "Splash_LED"]

        Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
            if index < imageNames.count {
                self.imageView.image = UIImage(named: imageNames[index])
                index += 1
            } else {
                timer.invalidate()
                DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
                    let vc = UINavigationController(rootViewController: DisplayBoardViewController())
                    vc.modalPresentationStyle = .fullScreen
                    vc.modalTransitionStyle = .flipHorizontal
                    self.present(vc, animated: true)
                }
            }
        }
    }

}
