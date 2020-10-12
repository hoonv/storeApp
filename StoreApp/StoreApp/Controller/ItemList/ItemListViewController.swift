//
//  ItemListViewController.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/05.
//

import UIKit
import NetworkHelper

class ItemListViewController: UIViewController {

    let cellReuseIdentifier = "ItemCollectionViewCell"
    let headerReuseIdentifier = "CollectionHeaderView"
    let badgeColors = [#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1),
                       #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1),
                       #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)]
    var itemViewModel = StoreItemViewModel()
    var imageView: UIImageView?

    @IBOutlet weak var itemCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(storeItemDidChange(_:)),
                                               name: .StoreItemDidChange,
                                               object: nil)
    }
    
    @objc func storeItemDidChange(_ sender: Notification) {
        DispatchQueue.main.async { [weak self] in
            self?.itemCollectionView.reloadData()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    private func setupCollectionView() {
        itemCollectionView.register(UINib(nibName: "ItemCollectionViewCell", bundle: nil),
                                    forCellWithReuseIdentifier: cellReuseIdentifier)
        itemCollectionView.register(UINib(nibName: "CollectionHeaderView",bundle: nil),
                                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                    withReuseIdentifier: headerReuseIdentifier)
        let layout = itemCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.sectionHeadersPinToVisibleBounds = true
    }
    
    func presentItemDetailViewController(with data: StoreItem) {
        guard let detailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }

        // 4
        detailViewController.transitioningDelegate = self

        detailViewController.modalPresentationStyle = .fullScreen
        detailViewController.data = data
        present(detailViewController, animated: true)
    }
}
