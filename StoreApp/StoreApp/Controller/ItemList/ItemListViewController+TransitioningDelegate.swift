//
//  ItemListViewController+TransitioningDelegate.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/12.
//

import UIKit

extension ItemListViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let firstViewController = presenting as? ItemListViewController,
              let secondViewController = presented as? DetailViewController,
              let selectedCellImageSnapShot = selectedImageSnapShot
        else { return nil }
        
        animator = FadeAnimator(type: .present,
                                firstViewController: firstViewController,
                                secondViewController: secondViewController,
                                selectedCellImageViewSnapshot: selectedCellImageSnapShot)
        
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let secondViewController = dismissed as? DetailViewController,
            let selectedCellImageViewSnapshot = selectedImageSnapShot
            else { return nil }

        animator = FadeAnimator(type: .dismiss,
                                firstViewController: self,
                                secondViewController: secondViewController,
                                selectedCellImageViewSnapshot: selectedCellImageViewSnapshot)
        return animator
    }
    
}
