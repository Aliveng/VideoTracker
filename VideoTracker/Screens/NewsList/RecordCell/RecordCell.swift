//
//  RecordCell.swift
//  VideoTracker
//
//  Created by Татьяна Севостьянова on 17.07.2020.
//  Copyright © 2020 Татьяна Севостьянова. All rights reserved.
//

import UIKit
import SnapKit


class RecordCell: UITableViewCell {
    
    static let reuseId = "RecordCell"
    
    var model: NewsItem? {
        didSet {
            self.playerView.imgView.image = model?.video.image
        }
    }
    
    lazy var headerView: HeaderView = {
        let view = HeaderView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var playerView: PlayerView = {
        let playerView = PlayerView()
        return playerView
    }()
    
    lazy var footerView: FooterView = {
        let view = FooterView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var grayLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .background
        return view
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playerView.imgView.image = nil
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .background
        
        addSubview(headerView)
        addSubview(playerView)
        addSubview(footerView)
        addSubview(grayLineView)
        
        headerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(57)
            $0.left.right.equalToSuperview()
        }
        
        playerView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(252)
        }
        
        footerView.snp.makeConstraints({ item in
            item.height.equalTo(53)
            item.left.equalToSuperview()
            item.right.equalToSuperview()
            item.top.equalTo(playerView.snp.bottom)
        })
        
        grayLineView.snp.makeConstraints({ item in
            item.height.equalTo(8)
            item.left.right.equalToSuperview()
            item.top.equalTo(footerView.snp.bottom)
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
