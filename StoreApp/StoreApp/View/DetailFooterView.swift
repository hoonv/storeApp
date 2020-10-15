//
//  DetailFooterView.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/14.
//

import UIKit

class DetailFooterView: UIView {

    let orderButton = UIButton()
    let basketButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    
    func setup() {
        self.backgroundColor = .secondarySystemBackground
        self.addBorder(toEdges: [.top], color: UIColor.systemGray, thickness: 1)
        orderButton.translatesAutoresizingMaskIntoConstraints = false
        orderButton.backgroundColor = .systemOrange
        orderButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        orderButton.setTitle("구매하기", for: .normal)
        orderButton.layer.cornerRadius = 5
        addSubview(orderButton)
        
        basketButton.backgroundColor = .white
        basketButton.translatesAutoresizingMaskIntoConstraints = false
        basketButton.setImage(UIImage.init(systemName: "cart"), for: .normal)
        basketButton.layer.cornerRadius = 5
        
        addSubview(basketButton)
        
        NSLayoutConstraint.activate([
            orderButton.leadingAnchor.constraint(equalTo: basketButton.trailingAnchor , constant: 10),
            orderButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            orderButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            orderButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),

            basketButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            basketButton.widthAnchor.constraint(equalTo: basketButton.heightAnchor),
            basketButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            basketButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }
}


extension UIView {
    func addBorder(toEdges edges: UIRectEdge, color: UIColor, thickness: CGFloat) {

        func addBorder(toEdge edges: UIRectEdge, color: UIColor, thickness: CGFloat) {
            let border = CALayer()
            border.backgroundColor = color.cgColor

            switch edges {
            case .top:
                border.frame = CGRect(x: 0, y: 0, width: frame.width, height: thickness)
            case .bottom:
                border.frame = CGRect(x: 0, y: frame.height - thickness, width: frame.width, height: thickness)
            case .left:
                border.frame = CGRect(x: 0, y: 0, width: thickness, height: frame.height)
            case .right:
                border.frame = CGRect(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
            default:
                break
            }

            layer.addSublayer(border)
        }

        if edges.contains(.top) || edges.contains(.all) {
            addBorder(toEdge: .top, color: color, thickness: thickness)
        }

        if edges.contains(.bottom) || edges.contains(.all) {
            addBorder(toEdge: .bottom, color: color, thickness: thickness)
        }

        if edges.contains(.left) || edges.contains(.all) {
            addBorder(toEdge: .left, color: color, thickness: thickness)
        }

        if edges.contains(.right) || edges.contains(.all) {
            addBorder(toEdge: .right, color: color, thickness: thickness)
        }
    }
}
