//
//  CoverView.swift
//  VideoTracker
//
//  Created by Кирилл Худяков on 18.07.2020.
//  Copyright © 2020 Татьяна Севостьянова. All rights reserved.
//


import UIKit
import MMPlayerView
import AVFoundation

extension UIImage {
    static let play = UIImage(imageLiteralResourceName: "playIcon")
    static let pause = UIImage(imageLiteralResourceName: "pauseIcon")
}


class CoverView: UIView, MMPlayerCoverViewProtocol {
    weak var playLayer: MMPlayerLayer?
    
    fileprivate var isUpdateTime = false

    lazy var playButton: UIButton = {
        let button = UIButton()
        button.addTarget(self,
                         action: #selector(didTapPlayButton),
                         for: .touchUpInside)
        return button
    }()
    
    lazy var progressSlider: UISlider = {
        let slider = UISlider()
        slider.addTarget(self,
                         action: #selector(sliderValueChange),
                         for: .valueChanged)
        return slider
    }()
    
    lazy var totalLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.textAlignment = .center
        return view
    }()
    
    lazy var currentLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.textAlignment = .center
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        playButton.imageView?.tintColor = .white
        addSubview(playButton)
        addSubview(progressSlider)
        addSubview(currentLabel)
        addSubview(totalLabel)
        
        playButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(50)
        }
        
        currentLabel.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(40)
        }

        totalLabel.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        progressSlider.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.leading.equalTo(currentLabel.snp.trailing)
            $0.right.equalTo(totalLabel.snp.left)
            $0.bottom.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapPlayButton() {
        self.playLayer?.delayHideCover()
        if playLayer?.player?.rate == 0{
            self.playLayer?.player?.play()
        } else {
            self.playLayer?.player?.pause()
        }
    }
    
    func currentPlayer(status: PlayStatus) {
        switch status {
        case .pause:
            playButton.setImage(.play, for: .normal)
        case .playing:
            playButton.setImage(.pause, for: .normal)
        default:
            playButton.setImage(.play, for: .normal)
        } 
    }
    
    func timerObserver(time: CMTime) {
        if let duration = playLayer?.player?.currentItem?.asset.duration,
            !duration.isIndefinite ,
            !isUpdateTime {
            if progressSlider.maximumValue != Float(duration.seconds) {
                progressSlider.maximumValue = Float(duration.seconds)
            }
            currentLabel.text = time.seconds.convertSecondString()
            totalLabel.text = (duration.seconds-time.seconds).convertSecondString()
            progressSlider.value = Float(time.seconds)
        }
    }
    
    @objc
    func sliderValueChange(slider: UISlider) {
        isUpdateTime = true
        playLayer?.delayHideCover()
        NSObject.cancelPreviousPerformRequests(withTarget: self,
                                               selector: #selector(delaySeekTime),
                                               object: nil)
        self.perform(#selector(delaySeekTime), with: nil, afterDelay: 0.1)
    }
    
    @objc
    private func delaySeekTime() {
        let time =  CMTimeMake(value: Int64(progressSlider.value), timescale: 1)
        self.playLayer?.player?.seek(to: time, completionHandler: { [unowned self] (finish) in
            self.isUpdateTime = false
        })
    }
    
    func player(isMuted: Bool) {
        
    }
}


extension TimeInterval {
    func convertSecondString() -> String {
        let component =  Date.dateComponentFrom(second: self)
        if let hour = component.hour ,
            let min = component.minute ,
            let sec = component.second {
            
            let fix =  hour > 0 ? NSString(format: "%02d:", hour) : ""
            let a = NSString(format: "%@%02d:%02d", fix,min,sec) as String
            return a
        } else {
            return "-:-"
        }
    }
}
