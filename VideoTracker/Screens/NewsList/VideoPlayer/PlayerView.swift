//
//  PlayerView.swift
//  VideoTracker
//
//  Created by Кирилл Худяков on 19.07.2020.
//  Copyright © 2020 Татьяна Севостьянова. All rights reserved.
//

import UIKit


final class PlayerView: UIView {
    
    lazy var imgView: UIImageView = UIImageView()
    lazy var timeLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(imgView)
        addSubview(timeLabel)
        
        imgView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}

