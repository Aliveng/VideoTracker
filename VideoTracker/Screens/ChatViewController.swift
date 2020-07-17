//
//  ChatViewController.swift
//  VideoTracker
//
//  Created by Татьяна Севостьянова on 16.07.2020.
//  Copyright © 2020 Татьяна Севостьянова. All rights reserved.
//


import UIKit
import SnapKit

class ChatViewController: UIViewController {
    
    override func loadView() {
        super.loadView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        navigationController?.navigationBar.isHidden = true
    }
}
