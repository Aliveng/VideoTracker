//
//  SimpleCell.swift
//  iDatchik_Profile
//
//  Created by Татьяна Севостьянова on 16.03.2020.
//  Copyright © 2020 Татьяна Севостьянова. All rights reserved.
//

import UIKit
import SnapKit


class SimpleCell: UITableViewCell {
    
    static let reuseId = "SimpleCell"
    
    lazy var simpleLabel: UILabel = {
        let view = UILabel()
        view.text = "О Приложении"
        view.textColor = .black
        view.font = .primary(size: 16, weight: .regular)
        view.textAlignment = .left
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .white
        addSubview(simpleLabel)
        
        simpleLabel.snp.makeConstraints({ item in
            item.height.equalTo(16)
            item.centerY.equalToSuperview()
            item.left.equalToSuperview().offset(14)
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
