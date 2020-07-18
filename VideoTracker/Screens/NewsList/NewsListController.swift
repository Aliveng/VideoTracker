////
////  ViewController.swift
////  VideoTracker
////
////  Created by Татьяна Севостьянова on 16.07.2020.
////  Copyright © 2020 Татьяна Севостьянова. All rights reserved.
////
//
//import UIKit
//import SnapKit
//
//
//enum RecordsModel {
//    case oneRecord
//    case twoRecord
//    case threeRecord
//}
//
////enum CellModel {
////    case newRecord(model: RecordsModel)
////}
////
////struct SectionModel {
////    let items: [CellModel]
////}
//
//class NewsListController: UIViewController {
//    
//    lazy var recordsTableView: UITableView = {
//        let view = UITableView.init(frame: .zero, style: UITableView.Style.grouped)
//        view.backgroundColor = .white
//        view.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
//        view.register(RecordCell.self, forCellReuseIdentifier: RecordCell.reuseId)
//        view.showsVerticalScrollIndicator = false
//        view.dataSource = self
//        view.delegate = self
//        return view
//    }()
//    
//    var sections: [Int: SectionModel] = [:]
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        title = "Лента"
//        view.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
//        
//        view.addSubview(recordsTableView)
//        
//        recordsTableView.snp.makeConstraints({ item in
//            item.top.equalToSuperview()
//            item.left.right.equalToSuperview()
//            item.bottom.equalToSuperview()
//        })
//        
//        sections[0] = SectionModel(items: [
////            .newRecord(model: .oneRecord),
////            .newRecord(model: .twoRecord),
////            .newRecord(model: .threeRecord)
//        ])
//    }
//}
//
//extension NewsListController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let cellModel = sections[indexPath.section]?.items[indexPath.row]
//        
//        switch cellModel {
//        case .newRecord:
//            return 360
//        case .none:
//            return 0
//        }
//    }
//}
//
//extension NewsListController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return sections[section]?.items.count ?? 0
//    }
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return sections.count
//    }
//    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        headerView.backgroundColor = UIColor.red
//        return headerView
//    }
//    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 0
//    }
//    
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let footerView = UIView()
//        footerView.backgroundColor = UIColor.green
//        return footerView
//    }
//    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 0
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let сellModel = sections[indexPath.section]?.items[indexPath.row]
//        
//        switch сellModel {
//        case let .newRecord(model: RecordsModel):
//            if let cell = tableView.dequeueReusableCell(withIdentifier: RecordCell.reuseId) as? RecordCell {
//                switch RecordsModel {
//                case .oneRecord:
//                    cell.headerView.avatarImageView.image = .avatar1
//                    cell.headerView.titleLabel.text = "Заголовок записи"
//                    cell.headerView.dateLabel.text = "15 мая 2020"
//                    cell.videoImageView.image = .video1
//                case .twoRecord:
//                    cell.headerView.avatarImageView.image = .avatar2
//                    cell.headerView.titleLabel.text = "Заголовок записи"
//                    cell.headerView.dateLabel.text = "14 мая 2020"
//                    cell.videoImageView.image = .video2
//                case .threeRecord:
//                    cell.headerView.avatarImageView.image = .avatar3
//                    cell.headerView.titleLabel.text = "Заголовок записи"
//                    cell.headerView.dateLabel.text = "13 мая 2020"
//                    cell.videoImageView.image = .video3
//                }
//                return cell
//            }
//        case .none:
//            return UITableViewCell()
//        }
//        return UITableViewCell()
//    }
//}
