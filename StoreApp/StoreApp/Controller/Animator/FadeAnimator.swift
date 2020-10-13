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
    private let secondViewController: DetailViewController
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

        
        guard let toView = secondViewController.view
            else {
                transitionContext.completeTransition(false)
                return
        }

        
        containerView.addSubview(toView)

        guard let selectedCell = firstViewController.selectedCell,
              let window = firstViewController.view.window ?? secondViewController.view.window,
              let cellImageSnapshot = selectedCell.imageView.snapshotView(afterScreenUpdates: true),
              let controllerImageSnapshot = secondViewController.hiddenImageView.snapshotView(afterScreenUpdates: true)
        else {
            transitionContext.completeTransition(true)
            return
        }
        let isPresenting = type.isPresenting
        
        let imageViewSnapshot: UIView
        
        if isPresenting {
            imageViewSnapshot = cellImageSnapshot
        } else {
            imageViewSnapshot = controllerImageSnapshot
        }

        imageViewSnapshot.contentMode = .scaleAspectFill

        toView.alpha = 0
        
        let tempImage = selectedCell.imageView.image

        if isPresenting {
            firstViewController.selectedCell?.imageView.image = nil
        }
        let firstViewSnapshot = firstViewController.view.snapshotView(afterScreenUpdates: true) ?? UIView()

        containerView.addSubview(firstViewSnapshot)

        [imageViewSnapshot].forEach { containerView.addSubview($0) }

        let controllerImageViewRect = secondViewController.hiddenImageView.convert(secondViewController.hiddenImageView.bounds, to: window)

        [imageViewSnapshot].forEach {
            $0.frame = isPresenting ? cellImageViewRect : controllerImageViewRect
        }
        
        UIView.animate(withDuration: Self.duration, animations: {                imageViewSnapshot.frame = isPresenting ? controllerImageViewRect : self.cellImageViewRect
        }, completion: {_ in
            
            imageViewSnapshot.removeFromSuperview()
            firstViewSnapshot.removeFromSuperview()
            toView.alpha = 1
            
            transitionContext.completeTransition(true)
            
            if !isPresenting {
                DispatchQueue.main.async { [weak self] in
                    self?.firstViewController.selectedCell?.imageView.image = tempImage
                    guard let idx = self?.firstViewController.itemCollectionView.indexPath(for: selectedCell) else { return }
                    self?.firstViewController.itemCollectionView.reloadItems(at: [idx])
                }
            }
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
