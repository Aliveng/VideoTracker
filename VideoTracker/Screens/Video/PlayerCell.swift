//
//  PlayerCell.swift
//  MMPlayerView
//
//  Created by Millman YANG on 2017/8/23.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit

struct DataObj {
    var image: UIImage
    var play_Url: URL?
    var title: String
    var content: String
}

class PlayerCell: UICollectionViewCell {
    
    static let id = "PlayerCell"
    
    var data: DataObj? {
        didSet {
            self.imgView.image = data?.image
            self.labTitle.text = data?.title
        }
    }
    
    lazy var imgView: UIImageView = UIImageView()
    
    lazy var labTitle: UILabel = UILabel()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imgView)
        addSubview(labTitle)
        
        imgView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imgView.isHidden = false
        data = nil
    }
}
