//
//  DetailDescriptionView.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/13.
//

import UIKit

class DetailDescriptionView: UIView {
    
    let title = UILabel()
    let nPrice = UILabel()
    let sPrice = UILabel()
    let salePercent = UILabel()
    let pointButton = UIButton()
    let deliveryFee = UILabel()
    let deliveryInfo = UILabel()
    var sPriceTopConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 2
        title.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        title.text = "title"
        
        sPrice.translatesAutoresizingMaskIntoConstraints = false
        sPrice.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        sPrice.textColor = UIColor(named: "PriceColor")
        sPrice.text = "0"
        
        nPrice.translatesAutoresizingMaskIntoConstraints = false
        nPrice.font = UIFont.systemFont(ofSize: 15)
        nPrice.textColor = UIColor.darkGray
        nPrice.text = "0"
        
        salePercent.translatesAutoresizingMaskIntoConstraints = false
        salePercent.font = UIFont.systemFont(ofSize: 15)
        salePercent.textColor = UIColor.darkGray
        salePercent.text = "0%"

        pointButton.translatesAutoresizingMaskIntoConstraints = false
        pointButton.layer.borderWidth = 2
        pointButton.layer.borderColor = UIColor.systemGray3.cgColor
        pointButton.layer.cornerRadius = 5
        pointButton.setTitle("💰 구매시 포인트 최대 56원 적립", for: .normal)
        pointButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        pointButton.setTitleColor(UIColor.black, for: .normal)
        
        deliveryFee.translatesAutoresizingMaskIntoConstraints = false
        deliveryFee.font = UIFont.systemFont(ofSize: 15, weight: .semibold)

        deliveryInfo.translatesAutoresizingMaskIntoConstraints = false
        deliveryInfo.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        deliveryInfo.numberOfLines = 2
        deliveryInfo.text = "🚛"
  
        addSubview(sPrice)
        addSubview(title)
        addSubview(nPrice)
        addSubview(salePercent)
        addSubview(pointButton)
        addSubview(deliveryInfo)
        addSubview(deliveryFee)
        
        sPriceTopConstraint = sPrice.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 40)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            sPriceTopConstraint,
            sPrice.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            
            salePercent.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            salePercent.bottomAnchor.constraint(equalTo: sPrice.topAnchor, constant: 0),

            nPrice.bottomAnchor.constraint(equalTo: salePercent.bottomAnchor),
            nPrice.leadingAnchor.constraint(equalTo: salePercent.trailingAnchor, constant: 0),
            
            pointButton.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            pointButton.trailingAnchor.constraint(equalTo: title.trailingAnchor),
            pointButton.topAnchor.constraint(equalTo: sPrice.bottomAnchor, constant: 20),
            pointButton.heightAnchor.constraint(equalToConstant: 40),
            
            deliveryFee.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            deliveryFee.trailingAnchor.constraint(equalTo: title.trailingAnchor),
            deliveryFee.topAnchor.constraint(equalTo: pointButton.bottomAnchor, constant: 20),
            
            deliveryInfo.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            deliveryInfo.trailingAnchor.constraint(equalTo: title.trailingAnchor),
            deliveryInfo.topAnchor.constraint(equalTo: deliveryFee.bottomAnchor, constant: 10),
        ])
    }
    
    func configure(viewModel: DetailViewModel) {
        
        title.text = viewModel.title
        sPrice.text = viewModel.sPrice
        
        if let nprice = viewModel.nPrice {
            nPrice.attributedText = "\(nprice)원".addCancelLine()
            salePercent.text = viewModel.salePercent
        } else {
            nPrice.text = ""
            salePercent.text = ""
            sPriceTopConstraint.constant = 25

        }
    }
    
    func configure(storeItem: DetailStoreItem) {
        
        let point = storeItem.data.point
        let fee = storeItem.data.deliveryFee
        let info = storeItem.data.deliveryInfo
        
        pointButton.setTitle("💰 구매시 포인트 최대 \(point) 적립", for: .normal)
        deliveryInfo.text = "🚛 \(info)"
        deliveryFee.text = "배송비 \(fee)"
    }
}
