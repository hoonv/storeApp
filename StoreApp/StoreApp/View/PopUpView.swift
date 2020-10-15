//
//  PopUpView.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/15.
//

import UIKit

class PopUpView: UIView {

    let moveTobasketButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        self.backgroundColor = .black
        self.layer.cornerRadius = 5
        let label = UILabel()
        label.text = "장바구니에 추가됐어요."
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        moveTobasketButton.setTitle("장바구니보기", for: .normal)
        moveTobasketButton.backgroundColor = .clear
        moveTobasketButton.translatesAutoresizingMaskIntoConstraints = false
        moveTobasketButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        moveTobasketButton.setTitleColor(.systemOrange, for: .normal)
        addSubview(label)
        addSubview(moveTobasketButton)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            label.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            
            moveTobasketButton.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 20),
            moveTobasketButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            moveTobasketButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            moveTobasketButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
   
    }
    
}
