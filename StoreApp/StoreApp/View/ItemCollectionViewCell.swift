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
        badgeStack.spacing = 5

    }

    func configure(with storeItem: StoreItem, badges: [String], colors: [UIColor]) {
        
        // setup
        title.text = storeItem.title
        desc.text = storeItem.description
        sPrice.text = storeItem.sPrice
        
        if let price = storeItem.nPrice {
            self.nPrice.attributedText = "\(price)원".addCancelLine()
        } else {
            sPriceLeadingConstraint.constant = 0
            nPrice.text = ""
        }
        
        //setup badge
        storeItem.badge?.forEach {
            let label = BadgeLabel(frame: CGRect.zero)
            let idx = badges.firstIndex(of: $0) ?? 0 % colors.count
            label.text = $0
            label.backgroundColor = colors[idx]
            label.translatesAutoresizingMaskIntoConstraints = false
            badgeStack.addArrangedSubview(label)
            NSLayoutConstraint.activate([
                label.heightAnchor.constraint(equalToConstant: badgeStack.frame.height),
            ])
        }
    }
    
    override func prepareForReuse() {
        sPriceLeadingConstraint.constant = 5
        badgeStack.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
    }
}
