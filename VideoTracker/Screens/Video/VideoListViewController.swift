import UIKit
import AVFoundation
import MMPlayerView
import SnapKit


class VideoListViewController: UIViewController {
    
    var videoItems: [NewsItem] = []
    
    var offsetObservation: NSKeyValueObservation?
    let coverView = CoverView()
    
    lazy var playerLayer: MMPlayerLayer = {
        let playerLayer = MMPlayerLayer()
        playerLayer.cacheType = .memory(count: 5)
        playerLayer.coverFitType = .fitToPlayerView
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        playerLayer.replace(cover: coverView)
        playerLayer.repeatWhenEnd = true
        playerLayer.player?.isMuted = true
        return playerLayer
    }()
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PlayerCell.self, forCellWithReuseIdentifier: PlayerCell.id)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 200, right:0)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Лента"
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        setupCollectionView()
        setupPlayerLayer()
        
        NewsService().getNewsItems { result in
            switch result {
            case let .success(items):
                videoItems = items
            case .failure:
                ()
            }
        }
    }
    
    private func setupCollectionView() {
        offsetObservation = collectionView.observe(\.contentOffset, options: [.new]) { [weak self] (_, value) in
            guard
                let self = self,
                self.presentedViewController == nil
            else {
                return
            }
            NSObject.cancelPreviousPerformRequests(withTarget: self)
            self.perform(#selector(self.startLoading), with: nil, afterDelay: 0.2)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
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
    
    func shrinkAction() {
        // Return a view which you want back
        playerLayer.shrinkView(onVC: self, isHiddenVC: false) { [weak self] () -> UIView? in
            guard
                let self = self,
                let path = self.findCurrentPath(),
                let cell = self.findCurrentCell(path: path) as? PlayerCell,
                let url = cell.data?.videoUrl
            else {
                return nil
            }
            
            self.playerLayer.set(url: url)
            self.playerLayer.resume()
            return cell.playerView.imgView
        }
    }
    
    deinit {
        offsetObservation?.invalidate()
        offsetObservation = nil
        print("ViewController deinit")
    }
}

// MARK: MMPlayerFromProtocol
extension VideoListViewController: MMPlayerFromProtocol {
    
    func backReplaceSuperView(original: UIView?) -> UIView? {
        guard let path = self.findCurrentPath() else {
            return original
        }
        
        let cell = self.findCurrentCell(path: path) as! PlayerCell
        return cell.playerView.imgView
    }

    
    var passPlayer: MMPlayerLayer {
        return self.playerLayer
    }
    
    func transitionWillStart() {}
    
    func transitionCompleted() {
        self.updateByContentOffset()
        self.startLoading()
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension VideoListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let minDimension = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
        return CGSize(width: minDimension, height: minDimension*0.75)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       DispatchQueue.main.async { [unowned self] in
        if self.presentedViewController != nil || self.playerLayer.isShrink == true {
                self.collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
                self.updateDetail(at: indexPath)
            } else {
                self.presentDetail(at: indexPath)
            }
        }
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

    fileprivate func updateDetail(at indexPath: IndexPath) {
        let value = videoItems[indexPath.row]
        
        playerLayer.thumbImageView.image = value.video.image
        playerLayer.set(url: value.video.videoUrl)
        playerLayer.resume()
    }
    
    fileprivate func presentDetail(at indexPath: IndexPath) {
        self.updateCell(at: indexPath)
        playerLayer.resume()
    }
    
    fileprivate func updateCell(at indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? PlayerCell, let playURL = cell.data?.videoUrl {
            // this thumb use when transition start and your video dosent start
            playerLayer.thumbImageView.image = cell.playerView.imgView.image
            // set video where to play
            playerLayer.playView = cell.playerView.imgView
            playerLayer.set(url: playURL)
        }
    }
    
    @objc
    fileprivate func startLoading() {
        self.updateByContentOffset()
        if self.presentedViewController != nil {
            return
        }
        // start loading video
        playerLayer.resume()
    }
    
    private func findCurrentPath() -> IndexPath? {
        let p = CGPoint(x: collectionView.frame.width/2, y: collectionView.contentOffset.y + collectionView.frame.width/2)
        return collectionView.indexPathForItem(at: p)
    }
    
    private func findCurrentCell(path: IndexPath) -> UICollectionViewCell {
        return collectionView.cellForItem(at: path)!
    }
}

// MARK: DataSource
extension VideoListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlayerCell.id, for: indexPath) as? PlayerCell {
            cell.data = videoItems[indexPath.row].video
            return cell
        }
        return UICollectionViewCell()
    }
}
