//
//  DetailViewController.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/11.
//

import UIKit
import NetworkHelper

class DetailViewController: UIViewController {

    @IBOutlet weak var hiddenImageView: UIImageView!
    @IBOutlet weak var imageScrollView: ImageScrollView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var descriptionView: DetailDescriptionView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var detailSectionStackView: UIStackView!
    @IBOutlet weak var footerView: DetailFooterView!
    @IBOutlet weak var popUpView: PopUpView!
    var detailItem: StoreItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDetailModel()
        footerView.basketButton.addTarget(self, action: #selector(basketOnTouch), for: .touchDown)
        popUpView.moveTobasketButton.addTarget(self, action: #selector(moveToBasketOnTouch), for: .touchDown)
        guard let item = detailItem else { return }
        hiddenImageView.setImageFromLocalOrNetwork(path: item.image, fileName: item.detailHash)
        let viewModel = DetailViewModel(item: item)
        descriptionView.configure(viewModel: viewModel)
    }
    
    func presentItemDetailViewController() {
        guard let itemBasketVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ItemBasketViewController") as? ItemBasketViewController else { return }

        present(itemBasketVC, animated: true)
    }
    
    
    @objc func moveToBasketOnTouch() {
        presentItemDetailViewController()
    }
    
    @objc func basketOnTouch() {
        if !popUpView.isHidden {
            return
        }
        popUpView.isHidden = false
        DispatchQueue.global().async {
            sleep(2)
            DispatchQueue.main.async { [weak self] in
                self?.popUpView.isHidden = true
            }
        }
    }
    
    private func fetchDetailModel() {
        guard let item = detailItem else { return }
        NetworkLayer.shared.dataTask(from: "\(Constant.detailURL)\(item.detailHash)") {
            (result: Result<DetailStoreItem,APIError>) in
            switch result {
            case .success(let model):
                self.configure(model: model)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func configure(model: DetailStoreItem) {

        DispatchQueue.global().async {
            let images = model.data.thumbImages.compactMap { $0.toURL()?.toUIImage() }
            
            DispatchQueue.main.async { [weak self] in
                guard let hiddenImage = self?.hiddenImageView.image else { return }
                self?.imageScrollView.configure(images: [hiddenImage] + images)
            }
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.descriptionView.configure(storeItem: model)
        }
        
        DispatchQueue.global().async {
            let images = model.data.detailSection.compactMap{ $0.toURL()?.toUIImage() }
            
            DispatchQueue.main.async { [weak self] in
                for image in images {
                    let imageView = UIImageView()
                    imageView.image = image
                    imageView.contentMode = .scaleAspectFit
                    self?.detailSectionStackView.addArrangedSubview(imageView)
                    imageView.translatesAutoresizingMaskIntoConstraints = false
                    imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1).isActive = true
                }
            }
        }
    }

    @IBAction func closeTouched(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension DetailViewController {
    
    enum Constant {
        static let detailURL = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/detail/"
    }
}
