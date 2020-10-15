//
//  DetailViewController+.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/16.
//

import UIKit

extension DetailViewController {
    
    func basketAnimation() {
        guard let snapshop = footerView.basketButton.snapshotView(afterScreenUpdates: false),
              let window = view.window
        else { return }
        let fromRect = footerView.basketButton.convert(footerView.basketButton.bounds, to: window)
        var toRect = popUpView.moveTobasketButton.convert(popUpView.moveTobasketButton.bounds, to: window)
        toRect.size.width = snapshop.frame.width / 2
        toRect.size.height = snapshop.frame.height / 2
        snapshop.frame = fromRect
        view.addSubview(snapshop)
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn ,animations: {
            snapshop.frame = toRect
        }, completion: { _ in
            snapshop.removeFromSuperview()
        })
    }
    
    
    func presentItemDetailViewController() {
        guard let itemBasketVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ItemBasketViewController") as? ItemBasketViewController else { return }
        present(itemBasketVC, animated: true)
    }
}
