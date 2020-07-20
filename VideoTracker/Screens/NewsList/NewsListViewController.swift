//
//  NewsListViewController.swift
//  VideoTracker
//
//  Created by Татьяна Севостьянова on 18.07.2020.
//  Copyright © 2020 Татьяна Севостьянова. All rights reserved.
//


import UIKit
import SnapKit
import AVFoundation
import MMPlayerView


enum CellModel {
    case newsItem(model: NewsItem)
}

struct SectionModel {
    let items: [CellModel]
}

class NewsListViewController: UIViewController {
    
    private let coverView = CoverView()
    
    private lazy var playerLayer: MMPlayerLayer = {
        let playerLayer = MMPlayerLayer()
        playerLayer.cacheType = .memory(count: 5)
        playerLayer.coverFitType = .fitToPlayerView
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        playerLayer.replace(cover: coverView)
        playerLayer.repeatWhenEnd = true
        playerLayer.player?.isMuted = true
        return playerLayer
    }()
    
    private lazy var recordsTableView: UITableView = {
        let view = UITableView.init(frame: .zero, style: UITableView.Style.grouped)
        view.backgroundColor = .background
        view.separatorStyle = .none
        view.register(RecordCell.self, forCellReuseIdentifier: RecordCell.reuseId)
        view.showsVerticalScrollIndicator = false
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    private var offsetObservation: NSKeyValueObservation?
    private var viewModel: NewsListViewModel
    private var sections: [Int: SectionModel] = [:]
    
    init(viewModel: NewsListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Лента"
        view.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        navigationController?.setNavigationBarHidden(false, animated: true)
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Roboto-Bold", size: 18)!]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        
        view.addSubview(recordsTableView)
        
        recordsTableView.snp.makeConstraints({ item in
            item.top.equalToSuperview()
            item.left.right.equalToSuperview()
            item.bottom.equalToSuperview()
        })
        
        setupTableView()
        setupPlayerLayer()
        
        viewModel.news
            .subscribe { [weak self] items in
                self?.sections[0] = SectionModel(items: items.map { CellModel.newsItem(model: $0) })
                self?.recordsTableView.reloadData()
        }
        
        viewModel.loadData()
    }
    
    private func setupTableView() {
        offsetObservation = recordsTableView.observe(\.contentOffset, options: [.new]) { [weak self] (_, value) in
            guard
                let self = self,
                self.presentedViewController == nil
                else {
                    return
            }
            NSObject.cancelPreviousPerformRequests(withTarget: self)
            self.perform(#selector(self.startLoading), with: nil, afterDelay: 0.2)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.updateByContentOffset()
            self?.startLoading()
        }
        
    }
    
    private func setupPlayerLayer() {
        navigationController?.mmPlayerTransition.push.pass(setting: { value in
            print(value)
        })
        
        playerLayer.getStatusBlock { [weak self] (status) in
            switch status {
            case let .failed(error):
                let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            case .ready:
                print("Ready to Play")
            case .playing:
                print("Playing")
            case .pause:
                print("Pause")
            case .end:
                print("End")
            default: break
            }
        }
        
        playerLayer.getOrientationChange { (status) in
            print("Player OrientationChange \(status)")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc
    func startLoading() {
        self.updateByContentOffset()
        if self.presentedViewController != nil {
            return
        }
        // start loading video
        playerLayer.resume()
    }
    
    fileprivate func updateByContentOffset() {
        if playerLayer.isShrink {
            return
        }
        
        if
            let path = findCurrentPath(),
            self.presentedViewController == nil
        {
            updateCell(at: path)
        }
    }
    
    private func findCurrentPath() -> IndexPath? {
        let point = CGPoint(x: recordsTableView.frame.width/2, y: recordsTableView.contentOffset.y + recordsTableView.frame.width/2)
        return recordsTableView.indexPathForRow(at: point)
    }
    
    private func findCurrentCell(path: IndexPath) -> UITableViewCell {
        return recordsTableView.cellForRow(at: path)!
    }
    
    
}

extension NewsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellModel = sections[indexPath.section]?.items[indexPath.row]
        
        switch cellModel {
        case .newsItem:
            return 368
        case .none:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async { [unowned self] in
            if self.presentedViewController != nil || self.playerLayer.isShrink == true {
                self.recordsTableView.scrollToRow(at: indexPath, at: .middle, animated: true)
                self.updateDetail(at: indexPath)
            } else {
                self.presentDetail(at: indexPath)
            }
        }
    }
    
    private func presentDetail(at indexPath: IndexPath) {
        self.updateCell(at: indexPath)
        playerLayer.resume()
    }
    
    fileprivate func updateDetail(at indexPath: IndexPath) {
        guard let сellModel = sections[indexPath.section]?.items[indexPath.row] else { return }
        
        switch сellModel {
        case let .newsItem(model):
            playerLayer.thumbImageView.image = model.video.image
            playerLayer.set(url: model.video.videoUrl)
            playerLayer.resume()
        }
        
    }
    
    private func updateCell(at indexPath: IndexPath) {
        if
            let cell = recordsTableView.cellForRow(at: indexPath) as? RecordCell,
            let playURL = cell.model?.video.videoUrl
        {
            // this thumb use when transition start and your video dosent start
            playerLayer.thumbImageView.image = cell.playerView.imgView.image
            // set video where to play
            playerLayer.playView = cell.playerView.imgView
            playerLayer.set(url: playURL)
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let сellModel = sections[indexPath.section]?.items[indexPath.row] else {
            return UITableViewCell()
        }
        
        switch сellModel {
        case let .newsItem(model: model):
            if let cell = tableView.dequeueReusableCell(withIdentifier: RecordCell.reuseId) as? RecordCell {
                cell.headerView.avatarImageView.image = model.avatar
                cell.headerView.titleLabel.text = model.title
                cell.headerView.dateLabel.text = model.publishDate.string
                cell.playerView.imgView.image = model.video.image
                cell.footerView.favoriteNumberLabel.text = model.likes.string
                cell.footerView.viewersNumberLabel.text = model.views.string
                cell.model = model
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
}
