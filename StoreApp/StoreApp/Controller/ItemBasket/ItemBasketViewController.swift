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
    
    var viewModel = ItemBasketViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerTableViewCell()
        setupBindings()
        viewModel.load()
    }
    
    private func setupUI() {
        orderButton.layer.cornerRadius = 5
        orderButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    
    private func registerTableViewCell() {
        itemTableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemTableViewCell")
    }
    
    private func setupBindings() {
        viewModel.orderButtonContent = { [weak self] content in
            self?.orderButton.setTitle(content, for: .normal)
        }
        viewModel.itemDidUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.itemTableView.reloadData()
            }
        }
    }
    
    @IBAction func backButtonOnTouch(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func orderButtonOnTouch(_ sender: Any) {
        viewModel.post(path: Constant.postURL) { [weak self] in
            self?.viewModel.clear()
            self?.present(defaultAlert(title: "주문이 완료되었습니다"), animated: true)
        }
    }
}

extension ItemBasketViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell") as? ItemTableViewCell else { return UITableViewCell() }
        
        let item = viewModel.items[indexPath.row]
        cell.configure(item: item.key, count: item.value)
        return cell
    }
}

extension ItemBasketViewController {
    
    enum Constant {
        static let postURL = "https://hooks.slack.com/services/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"
    }
}
