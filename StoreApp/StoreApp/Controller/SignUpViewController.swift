//
//  ViewController.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/09/28.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var idTextView: VerifyTextView!
    @IBOutlet weak var firstPWTextView: SecureVerifyTextView!
    @IBOutlet weak var secondPWTextView: SecureVerifyTextView!
    @IBOutlet weak var nameTextView: VerifyTextView!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        setupTextField()
        nextButton.layer.cornerRadius = 5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupTextField() {
        idTextView.dataSource = IdDataSource()
        idTextView.delegate = IdDelegate()
        firstPWTextView.dataSource = PWDataSource()
        firstPWTextView.delegate = PWDelegate()
        secondPWTextView.dataSource = PW1DataSource()
        secondPWTextView.delegate = self
        nameTextView.delegate = NameDelegate()
        nameTextView.dataSource = NameDataSource()
    }
    
    private func saveUserInfo() {
        let id = idTextView.textField.text ?? ""
        let password = firstPWTextView.textField.text ?? ""
        let name = nameTextView.textField.text ?? ""
    
        let user = User(id: id, password: password, name: name)
        let data = try? JSONEncoder().encode(user)
        UserDefaults.standard.setValue(data, forKey: "userinfo")
    }

    @objc func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y = -100
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func nextOnTouch(_ sender: Any) {
        if idTextView.isvalid() && firstPWTextView.isvalid()
            && secondPWTextView.isvalid() && nameTextView.isvalid(){
            saveUserInfo()

        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let itemList = storyboard.instantiateViewController(withIdentifier: "ItemListViewController")
        itemList.transitioningDelegate = self

        self.present(itemList, animated: true)
    }
}
