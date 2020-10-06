//
//  ItemListViewController.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/05.
//

import UIKit

class ItemListViewController: UIViewController {

    @IBOutlet weak var itemCollectionView: UICollectionView!
    let reuseIdentifier = "ItemCollectionViewCell"
    var items: [[StoreItem]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        items.append(StoreItemLoader.load(name: "main") ?? [])
        items.append(StoreItemLoader.load(name: "side") ?? [])
        items.append(StoreItemLoader.load(name: "soup") ?? [])
        itemCollectionView.register(UINib(nibName: "ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        itemCollectionView.register(UINib(nibName: "CollectionHeaderView",bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionHeaderView")
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self

    }
}

extension ItemListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
                            collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
}

extension ItemListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind.isEqual(UICollectionView.elementKindSectionHeader) {
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionHeaderView", for: indexPath) as! CollectionHeaderView
            cell.backgroundColor = .systemGray2
            return cell
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! ItemCollectionViewCell
        let item = items[indexPath.section][indexPath.item]
        let url = URL(string: item.image)
        DispatchQueue.main.async {
            do {
                let data = try Data(contentsOf: url!)
                cell.imageView.image = UIImage(data: data)
            } catch {
                print("error")
            }
        }
        cell.title.text = item.title
        cell.desc.text = item.description
        if let nPrice = item.nPrice {
            cell.sPrice.text = item.sPrice
            cell.nPrice.text = nPrice
        } else {
            cell.sPrice.text = item.sPrice
            cell.sPriceLeadingConstraint.constant = 0
            cell.nPrice.text = ""
        }
        return cell
    }
}
