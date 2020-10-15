//
//  ItemTableViewCell.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/15.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        itemImageView.layer.cornerRadius = itemImageView.frame.width / 16
        itemImageView.layer.masksToBounds = true
    }

    func configure(item: StoreItem, count: Int) {
        title.text = item.title
        price.text = item.sPrice
        itemImageView.image = item.image.toURL()?.toUIImage()
        self.count.text = "\(count)개"
        desc.text = item.description
    }
}
