//
//  File.swift
//  iDatchik_Profile
//
//  Created by Татьяна Севостьянова on 16.03.2020.
//  Copyright © 2020 Татьяна Севостьянова. All rights reserved.
//

import UIKit
import SnapKit


enum SimpleModel {
    case aboutApp
    case setting1
    case exit
}

enum SettingsCellModel {
    case simple(model: SimpleModel)
}

struct SettingsSectionModel {
    let items: [SettingsCellModel]
}


class SettingsViewController: UIViewController {
    
    lazy var settingsTableView: UITableView = {
        let view = UITableView.init(frame: .zero, style: UITableView.Style.grouped)
        view.separatorInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        view.register(SimpleCell.self, forCellReuseIdentifier: SimpleCell.reuseId)
        
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    var sections: [Int: SettingsSectionModel] = [:]
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(settingsTableView)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Настройки"
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.setNavigationBarHidden(false, animated: true)
        let attributes = [NSAttributedString.Key.font: UIFont.primary(size: 18, weight: .bold)]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        
        settingsTableView.snp.makeConstraints({ item in
            item.top.equalToSuperview()
            item.left.right.equalToSuperview()
            item.bottom.equalToSuperview()
        })
        
        sections[0] = SettingsSectionModel(items: [
            .simple(model: .aboutApp),
            .simple(model: .setting1),
            .simple(model: .exit)
        ])
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellModel = sections[indexPath.section]?.items[indexPath.row]
        
        switch cellModel {
        case .simple:
            return 52
        case .none:
            return 0
        }
        
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section]?.items.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 29
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = sections[indexPath.section]?.items[indexPath.row]
        
        switch cellModel {
        case let .simple(model: simpleModel):
            if let cell = tableView.dequeueReusableCell(withIdentifier: SimpleCell.reuseId) as? SimpleCell {
                switch simpleModel {
                case .aboutApp:
                    cell.simpleLabel.text = "О Приложении"
                case .setting1:
                    cell.simpleLabel.text = "Настройка 1"
                case .exit:
                    cell.simpleLabel.text = "Выйти"
                }
                return cell
            }
        case .none:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
}
