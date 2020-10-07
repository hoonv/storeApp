//
//  ItemCollectionViewCell.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/06.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var desc: UILabel!

    @IBOutlet weak var sPriceLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var nPrice: UILabel!
    @IBOutlet weak var sPrice: UILabel!
    @IBOutlet weak var badgeStack: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = imageView.frame.width / 16
        imageView.layer.masksToBounds = true
        badgeStack.distribution  = UIStackView.Distribution.equalSpacing
        badgeStack.alignment = UIStackView.Alignment.center
        badgeStack.spacing   = 5

    }

}
