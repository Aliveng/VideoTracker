import UIKit
import SnapKit


struct VideoItem {
    var image: UIImage
    var videoUrl: URL?
}

class PlayerCell: UICollectionViewCell {
    
    static let id = "PlayerCell"
    
    var data: VideoItem? {
        didSet {
            self.playerView.imgView.image = data?.image
        }
    }
    
    lazy var playerView: PlayerView = {
        PlayerView()
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(playerView)

        playerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.playerView.imgView.isHidden = false
        data = nil
    }
}


final class PlayerView: UIView {
    
    lazy var imgView: UIImageView = UIImageView()
    lazy var timeLabel: UILabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(imgView)
        addSubview(timeLabel)
        
        imgView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    private func setupConstraints() {}
}

