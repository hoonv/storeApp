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
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var salePercent: UILabel!
    @IBOutlet weak var itemNprice: UILabel!
    @IBOutlet weak var itemSprice: UILabel!

    @IBOutlet weak var descriptionView: DetailDescriptionView!
    var detailItem: StoreItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDetailModel()

        guard let item = detailItem else { return }
        setImageLocalOrNetwork(imageView: hiddenImageView, item: item)
        let viewModel = DetailViewModel(item: item)
        descriptionView.configure(viewModel: viewModel)
        
    }
    
    private func fetchDetailModel() {
        NetworkLayer.shared.dataTask(from: "\(Constant.detailURL)\(detailItem!.detailHash)") {
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
            let images = model.data.thumbImages
                .map {
                    try! Data(contentsOf: URL(string: $0)!)
                }.map {
                    UIImage(data: $0)!
                }
            DispatchQueue.main.async {
                guard let hiddenImage = self.hiddenImageView.image else { return }
                self.imageScrollView.configure(images: [hiddenImage] + images)
            }
        }
        DispatchQueue.main.async {
            self.descriptionView.configure(storeItem: model)
        }
    }
    
    @IBAction func closeTouched(_ sender: Any) {
        dismiss(animated: true)
    }
    
}

extension DetailViewController {
    
    enum Constant {
        static let detailURL = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/detail/"
    }
}
