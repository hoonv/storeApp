//
//  DetailViewController.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/11.
//

import UIKit
import NetworkHelper

protocol DetailViewDelegate: class {
    
    func detailView(_ detailView: DetailViewController, didAddToBasket item: StoreItem)
}

class DetailViewController: UIViewController {

    @IBOutlet weak var hiddenImageView: UIImageView!
    @IBOutlet weak var imageScrollView: ImageScrollView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var descriptionView: DetailDescriptionView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var detailSectionStackView: UIStackView!
    @IBOutlet weak var footerView: DetailFooterView!
    @IBOutlet weak var popUpView: PopUpView!
    
    weak var delegate: DetailViewDelegate?
    let viewModel = DetailViewModel()
    var animationImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenImageView.image = animationImage
        setupButtonTarget()
        setupBindings()
        viewModel.load()
        viewModel.request()
    }
    
    private func setupBindings() {
        viewModel.storeItem = { [weak self] (item: StoreItem, percent: String?) -> Void in
            DispatchQueue.main.async {
                self?.descriptionView.configure (storeItem: item, percent: percent)
            }
        }
        
        viewModel.detailStoreItem = { [weak self] (item: DetailStoreItem) -> Void in
            DispatchQueue.main.async {
                self?.descriptionView.configure(itemDetail: item)
            }
        }
        
        viewModel.thumbImages = {(images: [String]) -> Void in
            DispatchQueue.global().async {
                let uiImages = images.compactMap { $0.toURL()?.toUIImage() }
                
                DispatchQueue.main.async { [weak self] in
                    guard let hiddenImage = self?.hiddenImageView.image else { return }
                    self?.imageScrollView.configure(images: [hiddenImage] + uiImages)
                }
            }
        }
        
        viewModel.detailSection = { (images: [String]) -> Void in
            DispatchQueue.global().async {
                let uiImages = images.compactMap{ $0.toURL()?.toUIImage() }
                DispatchQueue.main.async { [weak self] in
                    for image in uiImages {
                        let imageView = UIImageView()
                        imageView.image = image
                        imageView.contentMode = .scaleAspectFit
                        self?.detailSectionStackView.addArrangedSubview(imageView)
                        imageView.translatesAutoresizingMaskIntoConstraints = false
                        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: image.size.height / image.size.width).isActive = true
                    }
                }
            }
        }
    }
    
    private func setupButtonTarget() {
        popUpView.moveTobasketButton.addTarget(self,
                                               action: #selector(moveToBasketOnTouch),
                                               for: .touchDown)
        footerView.orderButton.addTarget(self,
                                         action: #selector(order),
                                         for: .touchDown )
        footerView.basketButton.addTarget(self,
                                          action: #selector(basketOnTouch),
                                          for: .touchDown)
    }

    @objc func order() {
        viewModel.post() { [weak self] in
            self?.present(defaultAlert(title: "주문이 완료되었습니다"), animated: true)
        }
    }
    
    @objc func moveToBasketOnTouch() {
        presentItemDetailViewController()
    }
    
    @objc func basketOnTouch() {
        guard let item = viewModel.item else { return }
        if !popUpView.isHidden {
            return
        }
        delegate?.detailView(self, didAddToBasket: item)
        basketAnimation()
        popUpView.isHidden = false
        DispatchQueue.global().async {
            sleep(2)
            DispatchQueue.main.async { [weak self] in
                self?.popUpView.isHidden = true
            }
        }
    }
    
    @IBAction func closeTouched(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
