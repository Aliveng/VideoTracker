//
//  NavigationView.swift
//  iDatchik_Profile
//
//  Created by Татьяна Севостьянова on 17.03.2020.
//  Copyright © 2020 Татьяна Севостьянова. All rights reserved.
//

import UIKit
import  SnapKit

class NavigationView: UIView {
    
    let navigationController: UINavigationController
    
    lazy var newsLineButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .white
        view.setImage(.newsLine, for: .normal)
        view.addTarget(self,
                       action: #selector(didTapNewsLine),
                       for: .touchUpInside)
        return view
    }()
    
    lazy var categoriesButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .white
        view.setImage(.categories, for: .normal)
        view.addTarget(self,
                       action: #selector(didTapСategories),
                       for: .touchUpInside)
        return view
    }()
    
    lazy var chatButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .white
        view.setImage(.chat, for: .normal)
        view.addTarget(self,
                       action: #selector(didTapСhat),
                       for: .touchUpInside)
        return view
    }()
    
    lazy var settingsButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .white
        view.setImage(.settings, for: .normal)
        view.addTarget(self,
                       action: #selector(didTapSettings),
                       for: .touchUpInside)
        return view
    }()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init(frame: .zero)
        
        backgroundColor = .white
        addSubview(newsLineButton)
        addSubview(categoriesButton)
        addSubview(chatButton)
        addSubview(settingsButton)
        
        newsLineButton.snp.makeConstraints({ item in
            item.height.equalTo(26)
            item.width.equalTo(22.76)
            item.centerY.equalTo(categoriesButton.snp.centerY)
            item.right.equalTo(categoriesButton.snp.left).offset(-51)
            item.top.equalToSuperview().offset(8)
        })
        
        categoriesButton.snp.makeConstraints({
            $0.height.equalTo(28)
            $0.width.equalTo(28)
            $0.center.equalToSuperview().offset(-50)
            $0.top.equalToSuperview().offset(5)
        })
        
        chatButton.snp.makeConstraints({ item in
            item.height.equalTo(28)
            item.width.equalTo(28)
            item.centerY.equalTo(categoriesButton.snp.centerY)
            item.center.equalToSuperview().offset(60)
            item.top.equalToSuperview().offset(4)
        })
        
        settingsButton.snp.makeConstraints({ item in
            item.height.equalTo(26.25)
            item.width.equalTo(24.81)
            item.centerY.equalTo(categoriesButton.snp.centerY)
            item.left.equalTo(chatButton.snp.right).offset(53)
            item.top.equalToSuperview().offset(5.88)
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func didTapNewsLine() {
        //    navigationController.pushViewController(MoreViewController(), animated: true)
        print("Переход в Ленту")
    }
    
    @objc
    private func didTapСategories() {
        print("Переход в Категории")
    }
    
    @objc
    private func didTapСhat() {
        print("Переход в Чат")
    }
    
    @objc
    private func didTapSettings() {
        print("Переход к Настройкам")
    }
}
