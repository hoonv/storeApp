//
//  SignUpViewController+TransitioningDelegate.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/12.
//
import UIKit

extension SignUpViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideInAnimator()
    }
}
