//
//  ViewController.swift
//  Auto-ScrollView
//
//  Created by Rick on 2017/6/30.
//  Copyright © 2017年 CXZH. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ScrollViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let first = ScrollViewDataSourceModel.init()
        first.image = UIImage.init(named: "1")
        first.url = "1"
        
        let second = ScrollViewDataSourceModel.init()
        second.image = UIImage.init(named: "2")
        second.url = "2"
        
        let third = ScrollViewDataSourceModel.init()
        third.image = UIImage.init(named: "3")
        third.url = "3"
        let scrollView = ScrollView.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 200), data:[first, second, third])
        scrollView.scrollViewDelegate = self
        self.view.addSubview(scrollView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidSelectedItem(_ scrollView: ScrollView, _ itemIndex: Int) {
        
        print(itemIndex, "selected")
    }
}
