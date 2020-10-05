//
//  VerifyTextView.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/09/28.
//

import UIKit

class VerifyTextView: UIView {
    
    private let title = UILabel()
    private let textField = UITextField()
    private let message = UILabel()
    
    private let failColor = UIColor(red: 255/255, green: 242/255, blue: 242/255, alpha: 1)
    private let failBorder = UIColor.systemRed
    private let successBorder = UIColor(red: 100/255, green: 219/255, blue: 208/255, alpha: 1)
    private let successColor = UIColor(red: 241/255, green: 255/255, blue: 254/255, alpha: 1)
    private let defaultColor = UIColor.white
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        self.backgroundColor = .clear
        
        let iconView = UIImageView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = UIImage(named: "icon-tag")
        let iconContainerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 40, height: 30))
        iconContainerView.addSubview(iconView)
        
        textField.layer.cornerRadius = 10
        textField.backgroundColor = defaultColor
        textField.layer.borderColor = defaultColor.cgColor
        textField.layer.borderWidth = 2

        textField.delegate = self
        textField.leftView = iconContainerView
        textField.placeholder = "placeholder"
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)
        
        title.text = "Id"
        title.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        title.textColor = .systemGray
        title.translatesAutoresizingMaskIntoConstraints = false
        addSubview(title)
        
        message.text = ""
        message.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        message.translatesAutoresizingMaskIntoConstraints = false
        addSubview(message)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            title.heightAnchor.constraint(equalToConstant: 10),
            
            textField.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            textField.heightAnchor.constraint(lessThanOrEqualToConstant: 50),
            
            message.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 5),
            message.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            message.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
        ])
    }
}


extension VerifyTextView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(textField.text ?? "")
        NotificationCenter.default.post(name: .UIKeyboardWillShow, object: nil)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textField.text ?? "")
        guard let count = textField.text?.count else { return }
        NotificationCenter.default.post(name: .UIKeyboardWillHide, object: nil)

        if count > 5 {
            textField.backgroundColor = failColor
            textField.layer.borderColor = failBorder.cgColor
            title.textColor = failBorder
            message.textColor = failBorder
            message.text = "fail"
        } else {
            textField.backgroundColor = successColor
            textField.layer.borderColor = successBorder.cgColor
            title.textColor = successBorder
            message.textColor = successBorder
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        NotificationCenter.default.post(name: .UIKeyboardWillHide, object: nil)
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print(textField.text ?? "")


        print(1)
    }
}

extension UILabel {
  func addCharacterSpacing(kernValue: Double = 1.15) {
    if let labelText = text, labelText.count > 0 {
      let attributedString = NSMutableAttributedString(string: labelText)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: attributedString.length - 1))
      attributedText = attributedString
    }
  }
}
