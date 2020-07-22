////
////  HeaderDetailView.swift
////  VideoTracker
////
////  Created by Татьяна Севостьянова on 22.07.2020.
////  Copyright © 2020 Татьяна Севостьянова. All rights reserved.
////
//
//
//import UIKit
//import SnapKit
//
//
//class HeaderDetailView: UIView {
//
//    lazy var avatarImageView: UIImageView = {
//        let view = UIImageView(image: .avatar1)
//        return view
//    }()
//
//    lazy var titleLabel: UILabel = {
//        let view = UILabel()
//        view.text = "Заголовок записи"
//        view.textColor = .black
//        view.font = .primary(size: 14, weight: .bold)
//        view.textAlignment = .left
//        view.numberOfLines = 0
//        return view
//    }()
//
////    lazy var titleButton: UIButton = {
////        let view = UIButton()
////        view.backgroundColor = .clear
////        view.setTitle("Заголовок записи", for: .normal)
////        view.setTitleColor(.black, for: .normal)
////        view.titleLabel?.numberOfLines = 0
////        view.addTarget(self,
////                       action: #selector(didTapTitle),
////                       for: .touchUpInside)
////        return view
////    }()
//
//    lazy var dateLabel: UILabel = {
//        let view = UILabel()
//        view.text = "15 мая 2020"
//        view.textColor = .gray
//        view.font = .primary(size: 10, weight: .regular)
//        view.textAlignment = .left
//        view.numberOfLines = 0
//        return view
//    }()
//
//    lazy var shareImageView: UIImageView = {
//        let view = UIImageView(image: .share)
//        return view
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        addSubview(avatarImageView)
//        addSubview(titleLabel)
//      //  addSubview(titleButton)
//        addSubview(dateLabel)
//        addSubview(shareImageView)
//
//        avatarImageView.snp.makeConstraints({ item in
//            item.height.equalTo(38)
//            item.width.equalTo(38)
//            item.left.equalToSuperview().offset(8)
//            item.top.equalToSuperview().offset(11)
//            item.bottom.equalToSuperview().offset(-8)
//        })
//
//        titleLabel.snp.makeConstraints({ item in
//       // titleButton.snp.makeConstraints({ item in
//            item.left.equalTo(avatarImageView.snp.right).offset(18)
//            item.top.equalToSuperview().offset(19)
//            item.bottom.equalToSuperview().offset(-22)
//        })
//
//        dateLabel.snp.makeConstraints({ item in
//            item.left.equalTo(avatarImageView.snp.right).offset(18)
//            item.top.equalTo(titleLabel.snp.bottom)
//      //       item.top.equalTo(titleButton.snp.bottom)
//            item.bottom.equalToSuperview().offset(-6)
//        })
//
//        shareImageView.snp.makeConstraints({ item in
//            item.height.equalTo(28)
//            item.width.equalTo(28)
//            item.right.bottom.equalToSuperview().offset(-15)
//            item.top.equalToSuperview().offset(14)
//        })
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
////    @objc
////    private func didTapTitle() {
////        let controller = NewsDetailViewController()
////        navigationController.pushViewController(controller, animated: true)
////    }
//}
//
