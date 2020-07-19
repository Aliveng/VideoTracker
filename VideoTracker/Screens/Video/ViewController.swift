import UIKit
import AVFoundation
import MMPlayerView
import SnapKit


class VideoListViewController: UIViewController {
    
    var videoItems: [DataObj] = [
        DataObj.init(image: UIImage.authorizationBackground,
                     play_Url: URL(string: "https://firebasestorage.googleapis.com/v0/b/pitchit-f0ab2.appspot.com/o/uploads%2Fproducts%2F1MiZTVAoqyzHSjS7KeWE%2F1584740055.2414FCFC-32C7-4E99-BAE9-DD9A56C3C967.mov?alt=media&token=c30f6500-cd07-4a77-b2eb-a6b55c33793d"),
                     title: "One",
                     content: "Cat Tom"),
        DataObj.init(image: UIImage.authorizationBackground,
        play_Url: URL(string: "https://firebasestorage.googleapis.com/v0/b/pitchit-f0ab2.appspot.com/o/uploads%2Fproducts%2F3MQwiMjYXy5uKBo2ZlxX%2F1584561560.C0882799-AD01-44CB-8CF1-1A1751558752.mov?alt=media&token=1a944bef-b2b0-4037-a0ff-61a3c6f1d053"),
        title: "two",
        content: "Cat Tom")
    ]
    
    var offsetObservation: NSKeyValueObservation?
    
    lazy var mmPlayerLayer: MMPlayerLayer = {
        let l = MMPlayerLayer()
        l.cacheType = .memory(count: 5)
        l.coverFitType = .fitToPlayerView
        l.videoGravity = AVLayerVideoGravity.resizeAspect
//        l.replace(cover: CoverA.instantiateFromNib())
        l.repeatWhenEnd = true
        return l
    }()
    
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    
    private lazy var playerCollect: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PlayerCell.self, forCellWithReuseIdentifier: PlayerCell.id)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(playerCollect)
        
        playerCollect.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.navigationController?.mmPlayerTransition.push.pass(setting: { value in
            print(value)
        })
        
        offsetObservation = playerCollect.observe(\.contentOffset, options: [.new]) { [weak self] (_, value) in
            guard let self = self, self.presentedViewController == nil else {return}
            NSObject.cancelPreviousPerformRequests(withTarget: self)
            self.perform(#selector(self.startLoading), with: nil, afterDelay: 0.2)
        }
        
        playerCollect.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 200, right:0)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.updateByContentOffset()
            self?.startLoading()
        }
        
        mmPlayerLayer.getStatusBlock { [weak self] (status) in
            switch status {
            case .failed(let err):
                let alert = UIAlertController(title: "err", message: err.description, preferredStyle: .alert)
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
        mmPlayerLayer.getOrientationChange { (status) in
            print("Player OrientationChange \(status)")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    
    func shrinkAction() {
        // Return a view which you want back
        self.mmPlayerLayer.shrinkView(onVC: self, isHiddenVC: false) { [weak self] () -> UIView? in
            guard
                let self = self,
                let path = self.findCurrentPath(),
                let cell = self.findCurrentCell(path: path) as? PlayerCell,
                let url = cell.data?.play_Url
            else {
                return nil
            }
            
            self.mmPlayerLayer.set(url: url)
            self.mmPlayerLayer.resume()
            return cell.imgView
        }
    }
    
    deinit {
        offsetObservation?.invalidate()
        offsetObservation = nil
        print("ViewController deinit")
    }
}

// This protocol use to pass playerLayer to second UIViewcontroller
extension VideoListViewController: MMPlayerFromProtocol {
    // when second controller pop or dismiss, this help to put player back to where you want
    // original was player last view ex. it will be nil because of this view on reuse view
    func backReplaceSuperView(original: UIView?) -> UIView? {
        guard let path = self.findCurrentPath() else {
            return original
        }
        
        let cell = self.findCurrentCell(path: path) as! PlayerCell
        return cell.imgView
    }

    // add layer to temp view and pass to another controller
    var passPlayer: MMPlayerLayer {
        return self.mmPlayerLayer
    }
    func transitionWillStart() {
    }
    // show cell.image
    func transitionCompleted() {
        self.updateByContentOffset()
        self.startLoading()
    }
}

extension VideoListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let m = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
        return CGSize(width: m, height: m*0.75)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       DispatchQueue.main.async { [unowned self] in
        if self.presentedViewController != nil || self.mmPlayerLayer.isShrink == true {
                self.playerCollect.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
                self.updateDetail(at: indexPath)
            } else {
                self.presentDetail(at: indexPath)
            }
        }
    }
    
    fileprivate func updateByContentOffset() {
        if mmPlayerLayer.isShrink {
            return
        }
        
        if let path = findCurrentPath(),
            self.presentedViewController == nil {
            self.updateCell(at: path)
            //Demo SubTitle
            if path.row == 0,
                self.mmPlayerLayer.subtitleSetting.subtitleType == nil {
//                let subtitleStr = Bundle.main.path(forResource: "srtDemo", ofType: "srt")!
//                if let str = try? String.init(contentsOfFile: subtitleStr) {
//                    self.mmPlayerLayer.subtitleSetting.subtitleType = .srt(info: str)
//                    self.mmPlayerLayer.subtitleSetting.defaultTextColor = .red
//                    self.mmPlayerLayer.subtitleSetting.defaultFont = UIFont.boldSystemFont(ofSize: 20)
//                }
            }
        }
    }

    fileprivate func updateDetail(at indexPath: IndexPath) {
        let value = videoItems[indexPath.row]
//        if let detail = self.presentedViewController as? DetailViewController {
//            detail.data = value
//        }
        
        self.mmPlayerLayer.thumbImageView.image = value.image
        self.mmPlayerLayer.set(url: value.play_Url)
        self.mmPlayerLayer.resume()
        
    }
    
    fileprivate func presentDetail(at indexPath: IndexPath) {
        self.updateCell(at: indexPath)
        mmPlayerLayer.resume()
//        if let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
//            vc.data = DemoSource.shared.demoData[indexPath.row]
//            self.present(vc, animated: true, completion: nil)
//        }
    }
    
    fileprivate func updateCell(at indexPath: IndexPath) {
        if let cell = playerCollect.cellForItem(at: indexPath) as? PlayerCell, let playURL = cell.data?.play_Url {
            // this thumb use when transition start and your video dosent start
            mmPlayerLayer.thumbImageView.image = cell.imgView.image
            // set video where to play
            mmPlayerLayer.playView = cell.imgView
            mmPlayerLayer.set(url: playURL)
        }
    }
    
    @objc fileprivate func startLoading() {
        self.updateByContentOffset()
        if self.presentedViewController != nil {
            return
        }
        // start loading video
        mmPlayerLayer.resume()
    }
    
    private func findCurrentPath() -> IndexPath? {
        let p = CGPoint(x: playerCollect.frame.width/2, y: playerCollect.contentOffset.y + playerCollect.frame.width/2)
        return playerCollect.indexPathForItem(at: p)
    }
    
    private func findCurrentCell(path: IndexPath) -> UICollectionViewCell {
        return playerCollect.cellForItem(at: path)!
    }
}

extension VideoListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlayerCell.id, for: indexPath) as? PlayerCell {
            cell.data = videoItems[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
}
