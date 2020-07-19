//
//  FooterView.swift
//  VideoTracker
//
//  Created by Татьяна Севостьянова on 17.07.2020.
//  Copyright © 2020 Татьяна Севостьянова. All rights reserved.

import UIKit
import SnapKit


class FooterView: UIView {
    
    lazy var favoriteNumberLabel: UILabel = {
        let view = UILabel()
        view.text = "0"
        view.textColor = .black
        view.font = .primary(size: 10, weight: .bold)
        view.textAlignment = .left
        view.numberOfLines = 0
        return view
    }()
    
    lazy var viewersNumberLabel: UILabel = {
        let view = UILabel()
        view.text = "4k"
        view.textColor = .black
        view.font = .primary(size: 10, weight: .bold)
        view.textAlignment = .left
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var viewersImageView: UIImageView = {
        let view = UIImageView(image: .viewers)
        return view
    }()
    
    private lazy var favoriteButton: UIButton = {
        let view = UIButton()
        view.isEnabled = true
        view.tintColor = .black
        view.setImage(.favoriteEmpty, for: .normal)
        view.addTarget(self,
                       action: #selector(didTapFavorite),
                       for: .touchUpInside)
        return view
    }()
    
    private lazy var bookmarkImageView: UIImageView = {
        let view = UIImageView(image: .bookmarkEmpty)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(favoriteButton)
        addSubview(favoriteNumberLabel)
        addSubview(viewersImageView)
        addSubview(viewersNumberLabel)
        addSubview(bookmarkImageView)
        
        favoriteButton.snp.makeConstraints({ item in
            item.height.equalTo(28)
            item.width.equalTo(28)
            item.left.equalToSuperview().offset(13)
            item.top.equalToSuperview().offset(10)
            item.bottom.equalToSuperview().offset(-13)
        })

        favoriteNumberLabel.snp.makeConstraints({ item in
            item.left.equalTo(favoriteButton.snp.right).offset(4)
            item.centerY.equalTo(favoriteButton.snp.centerY)
        })

        viewersImageView.snp.makeConstraints({ item in
            item.height.equalTo(28)
            item.width.equalTo(28)
            item.left.equalTo(favoriteNumberLabel.snp.right).offset(11)
            item.top.equalToSuperview().offset(10)
            item.bottom.equalToSuperview().offset(-13)
        })

        viewersNumberLabel.snp.makeConstraints({ item in
            item.left.equalTo(viewersImageView.snp.right).offset(8)
            item.centerY.equalTo(viewersImageView.snp.centerY)
        })

        bookmarkImageView.snp.makeConstraints({ item in
            item.height.equalTo(28)
            item.width.equalTo(28)
            item.right.bottom.equalToSuperview().offset(-12)
            item.top.equalToSuperview().offset(13)
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func didTapFavorite() {
        favoriteButton.tintColor = .red
        if let likesCount = Int(favoriteNumberLabel.text ?? "") {
            favoriteNumberLabel.text = "\(likesCount + 1)"
        }
    }
}
