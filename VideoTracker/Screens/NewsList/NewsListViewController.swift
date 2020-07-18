//
//  NewsListViewController.swift
//  VideoTracker
//
//  Created by Татьяна Севостьянова on 18.07.2020.
//  Copyright © 2020 Татьяна Севостьянова. All rights reserved.
//


import UIKit
import SnapKit


struct Record {
    
    let avatar: UIImage
    let title: String
    let date: String
    let video: UIImage
    let isLiked: Bool
    let favoriteNumber: Int
    let viewsNumber: Int
    let isBookmark: Bool
    
}

enum CellModel {
    case record(model: Record)
}

struct SectionModel {
    let items: [CellModel]
}

class NewsListViewController: UIViewController {
    
    lazy var recordsTableView: UITableView = {
        let view = UITableView.init(frame: .zero, style: UITableView.Style.grouped)
        view.backgroundColor = .white
        view.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        view.register(RecordCell.self, forCellReuseIdentifier: RecordCell.reuseId)
        view.showsVerticalScrollIndicator = false
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    var sections: [Int: SectionModel] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Лента"
        view.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        
        view.addSubview(recordsTableView)
        
        recordsTableView.snp.makeConstraints({ item in
            item.top.equalToSuperview()
            item.left.right.equalToSuperview()
            item.bottom.equalToSuperview()
        })
        
        sections[0] = SectionModel(items: [
            .record(model: Record.init(avatar: .avatar1,
                                       title: "Запись один",
                                       date: "15 мая 2019",
                                       video: .video1,
                                       isLiked: false,
                                       favoriteNumber: 23,
                                       viewsNumber: 123,
                                       isBookmark: false)),
            .record(model: Record.init(avatar: .avatar2,
                                       title: "Запись два",
                                       date: "14 мая 2019",
                                       video: .video2,
                                       isLiked: false,
                                       favoriteNumber: 54,
                                       viewsNumber: 67,
                                       isBookmark: false)),
            .record(model: Record.init(avatar: .avatar3,
                                       title: "Запись три",
                                       date: "13 мая 2019",
                                       video: .video3,
                                       isLiked: false,
                                       favoriteNumber: 200,
                                       viewsNumber: 37,
                                       isBookmark: false)),

        ])
    }
}

extension NewsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellModel = sections[indexPath.section]?.items[indexPath.row]
        
        switch cellModel {
        case .record:
            return 360
        case .none:
            return 0
        }
    }
}

extension NewsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section]?.items.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.red
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.gray
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let сellModel = sections[indexPath.section]?.items[indexPath.row]
        
        switch сellModel {
        case let .record(model):
            if let cell = tableView.dequeueReusableCell(withIdentifier: RecordCell.reuseId) as? RecordCell {
                cell.headerView.avatarImageView.image = model.avatar
                cell.headerView.titleLabel.text = model.title
                cell.headerView.dateLabel.text = model.date
                cell.videoImageView.image = model.video
                cell.footerView.favoriteNumberLabel.text = "\(model.favoriteNumber)"
                cell.footerView.viewersNumberLabel.text = "\(model.viewsNumber)"
                return cell
            }
        case .none:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
}
