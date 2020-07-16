//
//  ViewController.swift
//  VideoTracker
//
//  Created by Татьяна Севостьянова on 16.07.2020.
//  Copyright © 2020 Татьяна Севостьянова. All rights reserved.
//

import UIKit
import SnapKit


class AuthorizationViewController: UIViewController {
    
    lazy var backgroundImgView: UIImageView = {
        let view = UIImageView()
        view.image = .authorizationBackground
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "Добро пожаловать в \n Название приложения"
        view.textAlignment = .center
        if Device.isSmall() {
            view.font = UIFont.init(name: "Roboto-Bold", size: 18)
        } else {
            view.font = UIFont.init(name: "Roboto-Bold", size: 20)
        }
        view.numberOfLines = 0
        return view
    }()
    
    lazy var subtitleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "Версия 1.0"
        view.textAlignment = .center
        if Device.isSmall() {
            view.font = UIFont.init(name: "Roboto-Bold", size: 16)
        } else {
            view.font = UIFont.init(name: "Roboto-Bold", size: 18)
        }
        view.numberOfLines = 0
        return view
    }()
    
    lazy var authorizationButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.setTitle("Авторизоваться", for: .normal)
        view.titleLabel?.font = UIFont.init(name: "Roboto-Bold", size: 18)
        view.setTitleColor( .black, for: .normal)
        view.addTarget(self,
                       action: #selector(didTapAuthorization),
                       for: .touchUpInside)
        return view
    }()
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .orange
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(backgroundImgView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(authorizationButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let topOffset = Device.isSmall() ? (view.frame.height / 3.5) : (view.frame.height / 3)
        
        backgroundImgView.snp.makeConstraints({ item in
            item.top.equalToSuperview()
            item.left.right.equalToSuperview()
            item.bottom.equalToSuperview()
        })
        
        titleLabel.snp.makeConstraints({ item in
            item.top.equalTo(topOffset)
            item.centerX.equalToSuperview()
        })
        
        subtitleLabel.snp.makeConstraints({ item in
            item.top.equalTo(titleLabel.snp.bottom).offset(5)
            item.centerX.equalToSuperview()
        })
        
        authorizationButton.snp.makeConstraints({ item in
            item.height.equalTo(40)
            item.left.equalToSuperview().offset(30)
            item.right.equalToSuperview().offset(-30)
            item.bottom.equalToSuperview().inset(29)
        })
    }
    
    @objc
    private func didTapAuthorization() {
        navigationController?.pushViewController(NewsLineViewController(), animated: true)
        print("Кнопка Авторизоваться")
    }
}
