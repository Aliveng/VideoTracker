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
    
    var viewModel: NewsDetailViewModel
    
    lazy var playerView: PlayerView = {
        let playerView = PlayerView()
        return playerView
    }()
    
    lazy var headerView: HeaderView = {
        let view = HeaderView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var textNewsLabel: UILabel = {
        let view = UILabel()
        view.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed aliquet massa feugiat lacus pulvinar lacus. Purus porttitor tincidunt sit tempor, metus, malesuada suspendisse. Odio nunc tempus quam aliquam praesent pellentesque. Ut egestas adipiscing non pellentesque. Nisl netus vel placerat ipsum cras laoreet. Orci turpis faucibus condimentum fringilla diam neque, nibh commodo vel. Habitant volutpat nunc, cursus sem sed amet. Facilisi aenean hendrerit interdum sit. Euismod elit amet porttitor nunc in elit donec quisque. Arcu at nec feugiat scelerisque malesuada. Congue etiam porttitor risus nunc morbi nulla donec ac gravida."
        view.textColor = #colorLiteral(red: 0.3019241393, green: 0.3019818664, blue: 0.3019204736, alpha: 1)
        view.textAlignment = .left
        view.font = .primary(size: 12, weight: .regular)
        return view
    }()
    
    init(viewModel: NewsDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(playerView)
        view.addSubview(headerView)
        view.addSubview(textNewsLabel)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.newsItem.title
        playerView.imgView.image = viewModel.newsItem.video.image
        
        view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        navigationController?.setNavigationBarHidden(false, animated: true)
        let attributes = [NSAttributedString.Key.font: UIFont.primary(size: 18, weight: .bold)]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        
        playerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(23)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(252)
        }
        
        headerView.snp.makeConstraints {
            $0.top.equalTo(playerView.snp.bottom)
            $0.height.equalTo(57)
            $0.left.right.equalToSuperview()
        }
        
        textNewsLabel.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(17)
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(9)
            $0.bottom.equalToSuperview().offset(-16)
        }
        
    }
    
}
