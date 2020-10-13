//
//  ItemListViewController+CollectionView.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/12.
//

import UIKit
import NetworkHelper

extension ItemListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
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
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind.isEqual(UICollectionView.elementKindSectionHeader) {
            guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: headerReuseIdentifier,
                                                                             for: indexPath)
                    as? CollectionHeaderView else { return UICollectionReusableView() }
            
            cell.category.text = itemViewModel.items[indexPath.section].category
            cell.title.text = itemViewModel.items[indexPath.section].title
            cell.backgroundColor = .systemBackground
            
            return cell
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath)
                as? ItemCollectionViewCell else { return UICollectionViewCell() }
        
        let item = itemViewModel.items[indexPath.section][indexPath.item]
        cell.configure(with: item, badges: itemViewModel.badges, colors: badgeColors)
        setImageLocalOrNetwork(imageView: cell.imageView, item: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailItem = itemViewModel.items[indexPath.section][indexPath.item]
        
        selectedCell = collectionView.cellForItem(at: indexPath) as? ItemCollectionViewCell
        selectedImageSnapShot = selectedCell?.imageView.snapshotView(afterScreenUpdates: false)
        
        presentItemDetailViewController(with: detailItem)
    }
}
