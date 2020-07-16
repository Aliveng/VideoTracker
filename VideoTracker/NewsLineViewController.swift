//
//  ViewController.swift
//  VideoTracker
//
//  Created by Татьяна Севостьянова on 16.07.2020.
//  Copyright © 2020 Татьяна Севостьянова. All rights reserved.
//

import UIKit
import SnapKit


class NewsLineViewController: UIViewController {
    
    lazy var bottomTapBar: NavigationView = {
        let view = NavigationView(navigationController: self.navigationController!)
        return view
    }()

    override func loadView() {
    super.loadView()
        
        view.backgroundColor = .green
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(bottomTapBar)
        
        bottomTapBar.snp.makeConstraints({ item in
            item.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            item.height.equalTo(56)
            item.left.equalToSuperview()
            item.right.equalToSuperview()
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
