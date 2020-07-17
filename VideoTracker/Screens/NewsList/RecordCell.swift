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
    
    lazy var headerView: HeaderView = {
        let view = HeaderView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var videoImageView: UIImageView = {
        let view = UIImageView(image: .video1)
        return view
    }()
    
    lazy var footerView: FooterView = {
        let view = FooterView()
        view.backgroundColor = .white
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .white
        addSubview(headerView)
        addSubview(videoImageView)
        addSubview(footerView)
        
        headerView.snp.makeConstraints({ item in
            item.height.equalTo(57)
            item.left.equalToSuperview()
            item.right.equalToSuperview()
            item.top.equalToSuperview()
        })
        
        videoImageView.snp.makeConstraints({ item in
            item.height.equalTo(252)
            item.left.equalToSuperview()
            item.right.equalToSuperview()
            item.top.equalTo(headerView.snp.bottom)
        })
        
        footerView.snp.makeConstraints({ item in
            item.height.equalTo(53)
            item.left.equalToSuperview()
            item.right.equalToSuperview()
            item.top.equalTo(videoImageView.snp.bottom)
        })

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
