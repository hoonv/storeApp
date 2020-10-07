//
//  BadgeLabel.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/07.
//

import UIKit

class BadgeLabel: UILabel {

    let inset = UIEdgeInsets(top: -2, left: 5, bottom: -2, right: 5)

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        self.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        self.textColor = UIColor.white
        self.textAlignment = .center
        self.backgroundColor = .systemBlue
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: inset))
    }

    override var intrinsicContentSize: CGSize {
        var intrinsicContentSize = super.intrinsicContentSize
        intrinsicContentSize.width += inset.left + inset.right
        intrinsicContentSize.height += inset.top + inset.bottom
        return intrinsicContentSize
    }

}
