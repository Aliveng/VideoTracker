//
//  itemCell.swift
//  BabyPink
//
//  Created by Татьяна Севостьянова on 28/10/2019.
//  Copyright © 2019 Татьяна Севостьянова. All rights reserved.
//

import UIKit
import SnapKit


class ItemCell: UICollectionViewCell {
    
    lazy var image: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    lazy var name: UILabel = {
        let view = UILabel()
        view.text = ""
        view.textColor = .white
        view.font = .primary(size: 18, weight: .bold)
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(image)
        addSubview(name)
        
        image.snp.makeConstraints({ item in
            item.height.equalToSuperview()
            item.left.equalToSuperview()
            item.right.equalToSuperview()
            item.top.equalToSuperview()
        })
        
        name.snp.makeConstraints({ item in
            item.center.equalToSuperview()
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
