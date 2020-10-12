//
//  FadeAnimator.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/12.
//

import UIKit

final class FadeAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var imageView: UIImageView?
    
    func transitionDuration(using ctx: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
    }
    
    func animationEnded(_ transitionCompleted: Bool) {
    }
    
}
