//
//  scrollView.swift
//  scrollView
//
//  Created by Rick on 2017/6/26.
//  Copyright © 2017年 CXZH. All rights reserved.
//

import UIKit

class ScrollView: UIView, UIScrollViewDelegate {

    weak var scrollViewDelegate: ScrollViewDelegate?
    
    private var firstImageView: UIImageView!
    private var secondImageView: UIImageView!
    private var thirdImageView: UIImageView!
    private var index = 0
    private var timer: Timer!
    var dataSource: Array<ScrollViewDataSourceModel>!
    
    
    var scrollView = UIScrollView.init()
    var indecator = UIPageControl.init()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    init(frame: CGRect, data: Array<ScrollViewDataSourceModel>) {
        super.init(frame: frame)
        self.scrollView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        self.scrollView.contentSize = CGSize(width: 3 * self.bounds.width, height: self.bounds.height)
        self.scrollView.isPagingEnabled = true
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.delegate = self
        self.scrollView.contentOffset.x = self.bounds.width
        self.addSubview(self.scrollView)
        self.dataSource = data
        self.setImageViews()
        self.setIndecator()
        self.startTimer()
    }
    
    func setIndecator() {
        
        self.indecator.frame.size = self.indecator.size(forNumberOfPages: self.dataSource.count)
        self.indecator.center = CGPoint(x: self.bounds.width * 0.5, y: self.bounds.height - self.indecator.bounds.height * 0.5)
        self.indecator.numberOfPages = self.dataSource.count
        self.insertSubview(self.indecator, aboveSubview: self.scrollView)
        self.indecator.currentPageIndicatorTintColor = UIColor.white
        self.indecator.pageIndicatorTintColor = UIColor.black
        self.indecator.currentPage = self.index
    }
    
    func setImageViews() {
        
        self.firstImageView = self.imageViewModel(withFrame: CGRect(x:0,
                                                                    y: 0,
                                                                    width: self.bounds.width,
                                                                    height: self.bounds.height),
                                                  model: self.dataSource.last!)
        
        self.secondImageView = self.imageViewModel(withFrame: CGRect(x: self.bounds.width,
                                                                     y: 0,
                                                                     width: self.bounds.width,
                                                                     height: self.bounds.height),
                                                   model: self.dataSource.first!)
        
        self.thirdImageView = self.imageViewModel(withFrame: CGRect(x: self.bounds.width * 2,
                                                                    y: 0,
                                                                    width: self.bounds.width,
                                                                    height: self.bounds.height),
                                                  model: self.dataSource[1])
    }
    
    func imageViewModel(withFrame frame: CGRect, model: ScrollViewDataSourceModel) -> UIImageView {
        
        let imageView = UIImageView.init(frame: frame);
        imageView.image = model.image
        imageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(didSelectedItem))
        imageView.addGestureRecognizer(tap);
        self.scrollView.addSubview(imageView)
        return imageView
    }
    
    @objc private func didSelectedItem() {
        
        if (self.scrollViewDelegate != nil) && (self.scrollViewDelegate?.responds(to: #selector(scrollViewDelegate?.scrollViewDidSelectedItem(_:_:))))! {
            self.scrollViewDelegate?.scrollViewDidSelectedItem(self, self.index)
        }
    }
        
    func scroll() {
        
        let point = CGPoint(x: self.bounds.width * 2, y: 0)
        self.scrollView.setContentOffset(point, animated: true)
    }
    
    private func startTimer() {
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: { (_) in
            self.scroll()
        })
    }
    
    ///scroll view delegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.updateImageViewModel(contentOffsetX: scrollView.contentOffset.x)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.updateImageViewModel(contentOffsetX: scrollView.contentOffset.x)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.timer.invalidate()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.startTimer()
    }
    
    func updateImageViewModel(contentOffsetX: CGFloat) {
        if contentOffsetX == 0 {
            self.index -= 1
            if self.index < 0 {
                self.index = self.dataSource.count - 1
            }
        } else if contentOffsetX == self.bounds.width * 2 {
            self.index += 1
            if self.index > self.dataSource.count - 1 {
                self.index = 0
            }
        }
        self.firstImageView.image = self.dataSource[self.index == 0 ? 2 : self.index - 1].image
        self.secondImageView.image = self.dataSource[self.index].image
        self.thirdImageView.image = self.dataSource[self.index == self.dataSource.count - 1 ? 0 : self.index + 1].image
        self.scrollView.contentOffset.x = self.bounds.width
        self.indecator.currentPage = self.index
    }
}

@objc protocol ScrollViewDelegate: NSObjectProtocol {
    func scrollViewDidSelectedItem(_ scrollView: ScrollView, _ itemIndex: Int)
}

class ScrollViewDataSourceModel: NSObject {
    var image: UIImage!
    var url: String!
    var imageUrl: String!
    
}
