//
//  ViewController.swift
//  VideoTracker
//
//  Created by Татьяна Севостьянова on 16.07.2020.
//  Copyright © 2020 Татьяна Севостьянова. All rights reserved.
//

import UIKit
import SnapKit


enum RecordsModel {
    case oneRecord
    case twoRecord
    case three
}

enum CellModel {
    case newRecord(model: RecordsModel)
}

struct SectionModel {
    let title: String
    let items: [CellModel]
}

class NewsListController: UIViewController {

    lazy var recordsTableView: UITableView = {
        let view = UITableView.init(frame: .zero, style: UITableView.Style.grouped)
        view.backgroundColor = .white
        view.separatorStyle = UITableViewCell.SeparatorStyle.none
        view.register(RecordCell.self, forCellReuseIdentifier: RecordCell.reuseId)
      //  view.dataSource = self
      //  view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Лента"
        view.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        
        navigationController?.navigationBar.barTintColor = UIColor.red
        navigationController?.navigationBar.barStyle = .default
        
    }
}
