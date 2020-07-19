//
//  ChatViewController.swift
//  VideoTracker
//
//  Created by Татьяна Севостьянова on 16.07.2020.
//  Copyright © 2020 Татьяна Севостьянова. All rights reserved.
//


import UIKit
import SnapKit
//import MessageKit

class ChatViewController: UIViewController {
    
    lazy var phraseOneView: UIView = {
        let view = UIView()
        return view
    }()
    
    private func phraseOneRoundedRectangle() {
        
        let rect = UIView(frame: .zero)
        rect.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        rect.clipsToBounds = true
        rect.layer.cornerRadius = 16
        rect.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
        phraseOneView.addSubview(rect)
        rect.snp.makeConstraints({ item in
            item.height.equalTo(42)
            item.left.right.equalToSuperview()
            item.top.equalToSuperview()
        })
    }
    
    lazy var textPhraseOne: UILabel = {
        let view = UILabel()
        view.text = "Привет!"
        view.textColor = .black
        view.textAlignment = .left
        view.font = .primary(size: 12, weight: .regular)
        view.numberOfLines = 0
        return view
    }()
    
    lazy var phraseTwoView: UIView = {
        let view = UIView()
        return view
    }()
    
    private func phraseTwoRoundedRectangle() {
        
        let rect = UIView(frame: .zero)
        rect.backgroundColor = #colorLiteral(red: 0.9022923189, green: 0.7800231193, blue: 0.50581925, alpha: 1)
        rect.clipsToBounds = true
        rect.layer.cornerRadius = 16
        rect.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
        phraseTwoView.addSubview(rect)
        rect.snp.makeConstraints({ item in
            item.height.equalTo(52)
            item.left.right.equalToSuperview()
            item.top.equalToSuperview()
        })
    }
    
    lazy var textPhraseTwo: UILabel = {
        let view = UILabel()
        view.text = "Привет! \n Как дела?"
        view.textColor = .black
        view.textAlignment = .left
        view.font = .primary(size: 12, weight: .regular)
        view.numberOfLines = 0
        return view
    }()
    
    override func loadView() {
        super.loadView()
        
        phraseOneRoundedRectangle()
        phraseTwoRoundedRectangle()
        
        view.addSubview(phraseOneView)
        phraseOneView.addSubview(textPhraseOne)
        view.addSubview(phraseTwoView)
        phraseTwoView.addSubview(textPhraseTwo)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Чат"
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        phraseOneView.snp.makeConstraints({ item in
            item.height.equalTo(42)
            item.left.equalToSuperview().offset(17)
            item.bottom.equalToSuperview().offset(-106)
        })
        
        textPhraseOne.snp.makeConstraints({ item in
            item.height.equalTo(16)
            item.left.equalToSuperview().offset(12)
            item.right.equalToSuperview().offset(-12)
            item.top.equalToSuperview().offset(12)
        })
        
        phraseTwoView.snp.makeConstraints({ item in
            item.height.equalTo(52)
            item.right.equalToSuperview().offset(-17)
            item.bottom.equalToSuperview().offset(-20)
        })
        
        textPhraseTwo.snp.makeConstraints({ item in
            item.height.equalTo(32)
            item.left.equalToSuperview().offset(12)
            item.right.equalToSuperview().offset(-12)
            item.top.equalToSuperview().offset(12)
        })
    }
}
