//
//  ItemListViewController.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/05.
//

import UIKit

class ItemListViewController: UIViewController {

    @IBOutlet weak var itemCollectionView: UICollectionView!
    private let cellReuseIdentifier = "ItemCollectionViewCell"
    private let headerReuseIdentifier = "CollectionHeaderView"
    private let badgeColors = [#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)]
    private var itemViewModel = StoreItemViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        itemCollectionView.register(UINib(nibName: "ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellReuseIdentifier)
        itemCollectionView.register(UINib(nibName: "CollectionHeaderView",bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier)
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        let layout = itemCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.sectionHeadersPinToVisibleBounds = true
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
        return itemViewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemViewModel.items[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind.isEqual(UICollectionView.elementKindSectionHeader) {
            guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuseIdentifier, for: indexPath) as? CollectionHeaderView
            else { return UICollectionReusableView() }
            cell.category.text = itemViewModel.headers[indexPath.section].category
            cell.title.text = itemViewModel.headers[indexPath.section].title
            cell.backgroundColor = .white
            
            return cell
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath as IndexPath) as? ItemCollectionViewCell else { return UICollectionViewCell() }
        let item = itemViewModel.items[indexPath.section][indexPath.item]
        
        // init cell
        cell.sPriceLeadingConstraint.constant = 5
        cell.badgeStack.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        
        // setup
        cell.title.text = item.title
        cell.desc.text = item.description
        cell.sPrice.text = item.sPrice
        
        if let nPrice = item.nPrice {
            cell.nPrice.attributedText = "\(nPrice)원".cancelLine()
        } else {
            cell.sPriceLeadingConstraint.constant = 0
            cell.nPrice.text = ""
        }
        
        DispatchQueue.global().async {
            do {
                guard let url = URL(string: item.image) else { return }
                let data = try Data(contentsOf: url)
                DispatchQueue.main.async {
                    cell.imageView.image = UIImage(data: data)
                }
            } catch {
                print("error")
            }
        }
        
        item.badge?.forEach {
            let label = BadgeLabel(frame: CGRect.zero)
            let idx = itemViewModel.badges.firstIndex(of: $0) ?? 0 % badgeColors.count
            label.text = $0
            label.backgroundColor = badgeColors[idx]
            label.translatesAutoresizingMaskIntoConstraints = false
            cell.badgeStack.addArrangedSubview(label)
            NSLayoutConstraint.activate([
                label.heightAnchor.constraint(equalToConstant: cell.badgeStack.frame.height),
            ])
        }

        return cell
    }
}
