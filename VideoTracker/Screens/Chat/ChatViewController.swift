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
        rect.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
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
    
    lazy var timePhraseOne: UILabel = {
        let view = UILabel()
        view.text = "11:37"
        view.textColor = .gray
        view.textAlignment = .right
        view.font = .primary(size: 10, weight: .regular)
        view.numberOfLines = 0
        return view
    }()
    
    lazy var phraseTwoView: UIView = {
        let view = UIView()
        return view
    }()
    
    private func phraseTwoRoundedRectangle() {
        
        let rect = UIView(frame: .zero)
        rect.backgroundColor = #colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 0.5529544454)
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
        view.text = "Привет!\nКак дела?"
        view.textColor = .black
        view.textAlignment = .left
        view.font = .primary(size: 12, weight: .regular)
        view.numberOfLines = 0
        return view
    }()
    
    lazy var timePhraseTwo: UILabel = {
        let view = UILabel()
      //  view.text = "\(Date().addingTimeInterval(-.hour))"
        view.text = "12:48"
        view.textColor = .gray
        view.textAlignment = .right
        view.font = .primary(size: 10, weight: .regular)
        view.numberOfLines = 0
        return view
    }()
    
    override func loadView() {
        super.loadView()
        
        phraseOneRoundedRectangle()
        phraseTwoRoundedRectangle()
        
        view.addSubview(phraseOneView)
        phraseOneView.addSubview(textPhraseOne)
        phraseOneView.addSubview(timePhraseOne)
        view.addSubview(phraseTwoView)
        phraseTwoView.addSubview(textPhraseTwo)
        phraseTwoView.addSubview(timePhraseTwo)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Чат"
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let attributes = [NSAttributedString.Key.font: UIFont.primary(size: 18, weight: .bold)]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        
        phraseOneView.snp.makeConstraints({ item in
            item.height.equalTo(42)
            item.width.equalTo(158)
            item.left.equalToSuperview().offset(17)
            item.bottom.equalToSuperview().offset(-106)
        })
        
        textPhraseOne.snp.makeConstraints({ item in
            item.height.equalTo(16)
            item.left.equalToSuperview().offset(12)
            item.right.equalToSuperview().offset(-12)
            item.top.equalToSuperview().offset(12)
        })
        
        timePhraseOne.snp.makeConstraints({ item in
            item.left.equalToSuperview()
            item.right.equalToSuperview().offset(-16)
            item.top.equalToSuperview().offset(22)
            item.bottom.equalToSuperview().offset(-4)
        })
        
        phraseTwoView.snp.makeConstraints({ item in
            item.height.equalTo(52)
            item.width.equalTo(158)
            item.right.equalToSuperview().offset(-17)
            item.bottom.equalToSuperview().offset(-20)
        })
        
        textPhraseTwo.snp.makeConstraints({ item in
            item.height.equalTo(32)
            item.left.equalToSuperview().offset(12)
            item.right.equalToSuperview().offset(-12)
            item.top.equalToSuperview().offset(12)
        })
        
        timePhraseTwo.snp.makeConstraints({ item in
            item.left.equalToSuperview()
            item.right.equalToSuperview().offset(-16)
            item.top.equalToSuperview().offset(37)
            item.bottom.equalToSuperview().offset(-4)
        })
    }
}
