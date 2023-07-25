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
    @IBOutlet var sendTextField: UITextField!
    @IBOutlet var viewText: UITextView!
    @IBOutlet var textColorButton: UIButton!
    
    let colorArray: [UIColor] = [.red, .orange, .yellow, .green, .blue, .purple]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sendView.layer.cornerRadius = 8
        desingButtons()
    }
    
    @IBAction func sendButtonClick(_ sender: UIButton) {
        viewText.text = sendTextField.text
        viewText.textColor = textColorButton.tintColor
        view.endEditing(true)
    }
    
    @IBAction func textColorChange(_ sender: UIButton) {
        
        //switch
//        switch sender.tintColor{
//            case UIColor.red
//            : sender.tintColor = .orange
//            case UIColor.orange
//            : sender.tintColor = .yellow
//            case UIColor.yellow
//            : sender.tintColor = .green
//            case UIColor.green
//            : sender.tintColor = .blue
//            case UIColor.blue
//            : sender.tintColor = .purple
//            case UIColor.purple
//            : sender.tintColor = .red
//            default: sender.tintColor = .red
//        }
        
        //Array
        //램덤
        //sender.tintColor = colorArray.randomElement()
        
        //순서대로
        sender.tintColor = colorArray[sender.tag]
        viewText.textColor = sender.tintColor
        
        if sender.tag < colorArray.count - 1{
            sender.tag += 1
        }else{
            sender.tag = 0
        }
    }
    
    @IBAction func textFieldEndOnExit(_ sender: UITextField) { }
    
    @IBAction func viewTapGesture(_ sender: UITapGestureRecognizer) {
        sendView.isHidden.toggle()
        view.endEditing(true)
    }
    
    func desingButtons(){
        for button in buttons{
            button.layer.borderWidth = 0.7
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.cornerRadius = 8
        }
    }
}
