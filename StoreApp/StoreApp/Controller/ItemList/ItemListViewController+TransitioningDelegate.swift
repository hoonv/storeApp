//
//  ItemListViewController+TransitioningDelegate.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/12.
//

import UIKit

extension ItemListViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transition = FadeAnimator()
        transition.imageView = self.imageView
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
    
}
