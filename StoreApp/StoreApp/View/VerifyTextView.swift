//
//  VerifyTextView.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/09/28.
//

import UIKit

class VerifyTextView: UIView {
    
    public var dataSource: VerifyTextViewDataSource? {
        didSet { setupUI() }
    }
    public var delegate: VerifyTextViewDelegate?
    private let title = UILabel()
    public let textField = UITextField()
    private let message = UILabel()
    private let iconView = UIImageView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
    
    private let defaultColor = UIColor(named: "TextFieldDefaultColor")
    private let failColor = UIColor(named: "TextFieldFailColor")
    private let successBorder = UIColor(named: "TextFieldPassBorderColor")
    private let successColor = UIColor(named: "TextFieldPassColor")
    private let failBorder = UIColor.systemRed
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        self.backgroundColor = .clear
        
        let iconContainerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 40, height: 30))
        iconView.image = UIImage(named: "icon-tag")
        iconView.contentMode = .scaleAspectFit
        iconContainerView.addSubview(iconView)
        textField.leftView = iconContainerView
        textField.leftViewMode = .always
        textField.delegate = self
        textField.layer.cornerRadius = 10
        textField.backgroundColor = defaultColor
        textField.layer.borderColor = defaultColor?.cgColor
        textField.layer.borderWidth = 2
        textField.placeholder = ""
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textContentType = .oneTimeCode
        addSubview(textField)
        
        title.text = "title"
        
        title.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        title.textColor = .systemGray
        title.translatesAutoresizingMaskIntoConstraints = false
        addSubview(title)
        
        message.text = ""
        message.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        message.translatesAutoresizingMaskIntoConstraints = false
        addSubview(message)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            title.heightAnchor.constraint(equalToConstant: 20),
            
            textField.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            textField.bottomAnchor.constraint(equalTo: message.topAnchor, constant: -5),
            
            message.heightAnchor.constraint(equalToConstant: 20),
            message.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            message.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
        ])
    }

    private func verify(input: String) {
        guard let msg = delegate?.verify(input: input) else { return }
        
        if msg == delegate?.pass {
            textField.backgroundColor = successColor
            textField.layer.borderColor = successBorder?.cgColor
            iconView.image = dataSource?.passIcon() ?? UIImage(named: "icon-tag-cyan")
            title.textColor = successBorder
            message.textColor = successBorder
            message.text = msg.rawValue
        } else {
            textField.backgroundColor = failColor
            textField.layer.borderColor = failBorder.cgColor
            iconView.image = dataSource?.failIcon() ?? UIImage(named: "icon-tag-red")
            title.textColor = failBorder
            message.textColor = failBorder
            message.text = msg.rawValue
        }
    }
    
    public func isvalid() -> Bool {
        let text = textField.text ?? ""
        guard let msg = delegate?.verify(input: text ) else { return false }
        
        if msg == delegate?.pass {
            return true
        }
        verify(input: text)
        return false
    }
    
    private func setupUI() {
        iconView.image = dataSource?.defaultIcon() ?? UIImage(named: "icon-tag")
        textField.placeholder = dataSource?.placeholder() ?? ""
        title.text = dataSource?.title() ?? "title"
    }
}


extension VerifyTextView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        NotificationCenter.default.post(name: .UIKeyboardWillShow, object: nil)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        NotificationCenter.default.post(name: .UIKeyboardWillHide, object: nil)
        verify(input: textField.text ?? "")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        NotificationCenter.default.post(name: .UIKeyboardWillHide, object: nil)
        textField.resignFirstResponder()
        return true
    }
}
