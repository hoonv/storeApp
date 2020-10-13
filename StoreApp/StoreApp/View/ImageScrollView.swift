//
//  ImageScrollView.swift
//  StoreApp
//
//  Created by 채훈기 on 2020/10/13.
//

import UIKit

class ImageScrollView: UIView {

    var controlPage = UIPageControl()
    var scrollView = UIScrollView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(images: [UIImage]) {
        
        scrollView = UIScrollView(frame: self.frame)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.contentSize = CGSize(
            width: self.frame.width * CGFloat(images.count),
            height: self.frame.height
        )
        
        for (index, image) in images.enumerated() {
            let subView = UIImageView()
            subView.contentMode = .scaleAspectFill
            subView.frame = self.frame
            subView.image = image
            subView.frame.origin.x = self.frame.width * CGFloat(index)
            scrollView.addSubview(subView)
        }
        
        controlPage = UIPageControl(frame: CGRect(x: (frame.width - 200) / 2,
                                                  y: frame.height - 30,
                                                  width: 200,
                                                  height: 30))
        controlPage.numberOfPages = images.count
        controlPage.tintColor = .white
        controlPage.pageIndicatorTintColor = .gray

        addSubview(scrollView)
        addSubview(controlPage)

    }

}

extension ImageScrollView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        controlPage.currentPage = Int(floor(scrollView.contentOffset.x / UIScreen.main.bounds.width))
    }
}
