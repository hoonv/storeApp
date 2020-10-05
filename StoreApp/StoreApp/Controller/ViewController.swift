//
//  ViewController.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/09/28.
//

import UIKit


extension Notification.Name {
    static let UIKeyboardWillShow = Notification.Name("UIKeyboardWillShow")
    static let UIKeyboardWillHide = Notification.Name("UIKeyboardWillHide")
}

class ViewController: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 243/255, green: 247/255, blue: 253/255, alpha: 1)
        nextButton.layer.cornerRadius = 5
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
        
    }

    @objc func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y = -150
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        print("XXXXX")
        self.view.frame.origin.y = 0
    }



    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

