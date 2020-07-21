//
//  NewsDetaile.swift
//  VideoTracker
//
//  Created by Татьяна Севостьянова on 21.07.2020.
//  Copyright © 2020 Татьяна Севостьянова. All rights reserved.
//

import UIKit
import SnapKit


class NewsDetailViewController: UIViewController {
    
//    lazy var shareImageView: UIImageView = {
//         let view = UIImageView(image: .share)
//         return view
//     }()
    
    override func loadView() {
        super.loadView()
        
      //  view.addSubview(shareImageView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Такая-то запись из ленты"
        view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        navigationController?.setNavigationBarHidden(false, animated: true)
        let attributes = [NSAttributedString.Key.font: UIFont.primary(size: 18, weight: .bold)]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
    }
    
}
