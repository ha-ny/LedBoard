//
//  LedBoardViewController.swift
//  LedBoard
//
//  Created by 김하은 on 2023/07/25.
//

import UIKit

class LedBoardViewController: UIViewController {

    @IBOutlet var sendView: UIView!
    @IBOutlet var buttons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sendView.layer.cornerRadius = 8
        desingButtons()
    }
    
    func desingButtons(){
        for button in buttons{
            button.layer.borderWidth = 0.5
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.cornerRadius = 8
        }
    }
}
