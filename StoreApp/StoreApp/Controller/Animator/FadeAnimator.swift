//
//  FadeAnimator.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/12.
//

import UIKit

final class FadeAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    static let duration: TimeInterval = 0.5
    private let type: PresentationType
    private let firstViewController: ItemListViewController
    private var secondViewController: DetailViewController?
    private var selectedCellImageViewSnapshot: UIView
    private let cellImageViewRect: CGRect

    init?(type: PresentationType,
          firstViewController: ItemListViewController,
          secondViewController: DetailViewController,
          selectedCellImageViewSnapshot: UIView) {
        
        self.type = type
        self.firstViewController = firstViewController
        self.secondViewController = secondViewController
        self.selectedCellImageViewSnapshot = selectedCellImageViewSnapshot

        guard let window = firstViewController.view.window ?? secondViewController.view.window,
            let selectedCell = firstViewController.selectedCell
            else { return nil }
    
        self.cellImageViewRect = selectedCell.imageView.convert(selectedCell.imageView.bounds, to: window)
    }


    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Self.duration
    }


    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
        let containerView = transitionContext.containerView
        guard let secondViewController = secondViewController else {
            transitionContext.completeTransition(false)
            return
        }
        
        guard let toView = secondViewController.view else {
            transitionContext.completeTransition(false)
            return
        }

        containerView.addSubview(toView)

        guard let selectedCell = firstViewController.selectedCell,
              let window = firstViewController.view.window ?? secondViewController.view.window,
              let controllerImageSnapshot = secondViewController.hiddenImageView.snapshotView(afterScreenUpdates: true),
              let descriptionSnapshot = secondViewController.descriptionView.snapshotView(afterScreenUpdates: true)
        else {
            transitionContext.completeTransition(true)
            return
        }
        
        let tempImage = selectedCell.imageView.image
        let isPresenting = type.isPresenting
        let backgroundView = UIView()
        if isPresenting {
            firstViewController.selectedCell?.imageView.image = nil
        }
        let firstViewSnapshot = firstViewController.view.snapshotView(afterScreenUpdates: true) ?? UIView()
        let controllerImageViewRect = secondViewController.hiddenImageView.convert(secondViewController.hiddenImageView.bounds, to: window)
        let descriptionViewRect = secondViewController.descriptionView.convert(secondViewController.descriptionView.bounds, to: window)
        var backgoundViewRect = descriptionViewRect
        
        backgroundView.backgroundColor = secondViewController.view.backgroundColor
        backgoundViewRect.origin.y += descriptionViewRect.height
        toView.alpha = 0
        
        [firstViewSnapshot,
         selectedCellImageViewSnapshot,
         controllerImageSnapshot,
         descriptionSnapshot,
         backgroundView].forEach { containerView.addSubview($0) }

        descriptionSnapshot.frame = descriptionViewRect
        backgroundView.frame = backgoundViewRect
        [selectedCellImageViewSnapshot, controllerImageSnapshot].forEach {
            $0.frame = isPresenting ? cellImageViewRect : controllerImageViewRect
        }
        
        descriptionSnapshot.alpha = isPresenting ? 0 : 1
        controllerImageSnapshot.alpha = isPresenting ? 0 : 1
        selectedCellImageViewSnapshot.alpha = isPresenting ? 1 : 0
        backgroundView.alpha = isPresenting ? 0 : 1
        
        UIView.animateKeyframes(withDuration: Self.duration, delay: 0, options: .calculationModeCubic, animations: {

            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                self.selectedCellImageViewSnapshot.frame = isPresenting ? controllerImageViewRect : self.cellImageViewRect
                controllerImageSnapshot.frame = isPresenting ? controllerImageViewRect : self.cellImageViewRect
                descriptionSnapshot.alpha = isPresenting ? 1: 0
                backgroundView.alpha = isPresenting ? 1: 0
            }

            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.6) {
                self.selectedCellImageViewSnapshot.alpha = isPresenting ? 0 : 1
                controllerImageSnapshot.alpha = isPresenting ? 1 : 0
            }
            
        }, completion: { _ in
            
            [self.selectedCellImageViewSnapshot,
             controllerImageSnapshot,
             firstViewSnapshot,
             descriptionSnapshot,
             backgroundView].forEach { $0.removeFromSuperview() }
            
            toView.alpha = 1
            
            if !isPresenting {
                DispatchQueue.main.async { [weak self] in
                    self?.firstViewController.selectedCell?.imageView.image = tempImage
                    guard let idx = self?.firstViewController.itemCollectionView.indexPath(for: selectedCell) else { return }
                    self?.firstViewController.itemCollectionView.reloadItems(at: [idx])
                }
            }
            self.secondViewController = nil
            transitionContext.completeTransition(true)
        })
    }
}

enum PresentationType {

    case present
    case dismiss

    var isPresenting: Bool {
        return self == .present
    }
}
