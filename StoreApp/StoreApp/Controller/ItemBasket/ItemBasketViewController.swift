//
//  ItemBasketViewController.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/15.
//

import UIKit

class ItemBasketViewController: UIViewController {

    @IBOutlet weak var itemTableView: UITableView!
    @IBOutlet weak var orderButton: UIButton!

    var itemBasket = ItemBasket.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderButton.layer.cornerRadius = 5
        orderButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        orderButton.setTitle("주문하기 \(itemBasket.totalPrice)원", for: .normal)
        itemTableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemTableViewCell")
        
    }
    
    @IBAction func backButtonOnTouch(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}

extension ItemBasketViewController: UITableViewDelegate {
    
}


extension ItemBasketViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemBasket.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell") as? ItemTableViewCell else { return UITableViewCell() }
        let item = Array(itemBasket.items)[indexPath.row]
        cell.configure(item: item.key, count: item.value)
        return cell
    }
}

