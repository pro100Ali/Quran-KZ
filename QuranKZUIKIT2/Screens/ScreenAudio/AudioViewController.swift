//
//  AudioViewController.swift
//  QuranKZUIKIT2
//
//  Created by Али  on 19.06.2023.
//

import UIKit
import SnapKit
import AVFoundation

class AudioViewController: UIViewController {
    
    var audioPlayer: AVPlayer!
    
    var playerItem: AVPlayerItem?
    fileprivate let seekDuration: Float64 = 10

    var audio: Audio!
    var surah: Surah!
    var viewModel: AudioViewModel!
    private var isPlayed = true
    
    lazy private var rect: UIView = {
        let rect = UIView()
        rect.layer.cornerRadius = 15
        rect.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        return rect
    }()
    
    lazy private var circle: UIView = {
        let circle = UIView()
        circle.layer.cornerRadius = 30
        //        circle.backgroundColor = UIColor(red: 0.19, green: 0.30, blue: 0.53, alpha: 1.00)
        circle.backgroundColor = Color.shared.blueRect
        return circle
    }()
    
    lazy private var playButton: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
        let config = UIImage.SymbolConfiguration(
            pointSize: 30, weight: .medium, scale: .default)
        let image = UIImage(systemName: "pause", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(playAction), for: .touchUpInside)
        return button
    }()
    
    lazy private var backwardButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(
            pointSize: 20, weight: .light, scale: .default)
        let image = UIImage(systemName: "backward.fill", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        
        return button
    }()
    
    
    lazy private var forwardButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(
            pointSize: 20, weight: .light, scale: .default)
        let image = UIImage(systemName: "forward.fill", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        
        return button
    }()
    
    lazy private var randomButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(
            pointSize: 20, weight: .semibold, scale: .default)
        let image = UIImage(systemName: "arrow.2.squarepath", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        
        return button
    }()
    
    lazy private var listButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(
            pointSize: 20, weight: .semibold, scale: .default)
        let image = UIImage(systemName: "music.note.list", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        
        return button
    }()
    
    lazy private var image: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "musicImage")
        return iv
    }()
    
    lazy private var nameSong: UILabel = {
        let text = UILabel()
        text.text = "On the ground"
        text.font = UIFont.systemFont(ofSize: 23, weight: .semibold)
        return text
    }()
    
    lazy private var descriptionName: UILabel = {
        let label = UILabel()
        label.text = "--:--"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    lazy private var currentDuraation: UILabel = {
        let label = UILabel()
        label.text = "--:--"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    
    
    lazy private var playbackSlider: UISlider = {
       let slider = UISlider()
       slider.minimumValue = 0
        slider.maximumValue = Float(100)
        slider.isContinuous = true
        slider.thumbTintColor = Color.shared.blueRect
        slider.minimumTrackTintColor = Color.shared.blueRect
        return slider
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        [rect, image].forEach { view.addSubview($0) }
        circle.addSubview(playButton)
        [nameSong, descriptionName, circle, backwardButton, forwardButton, randomButton, listButton, playbackSlider, currentDuraation].forEach { rect.addSubview($0) }
        setupConstraints()
    }
    override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           
        audioPlayer.pause() 
       }
    
    func loadAudioFile(with url: String) {
        
        
        let url = URL(string: url)
        
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        audioPlayer = AVPlayer(playerItem: playerItem)
        
        
        let duration : CMTime = playerItem.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)
        
        descriptionName.text = self.stringFromTimeInterval(interval: seconds)
        
        
        let currentDuration : CMTime = playerItem.currentTime()
            let currentSeconds : Float64 = CMTimeGetSeconds(currentDuration)
            currentDuraation.text = self.stringFromTimeInterval(interval: currentSeconds)
            
        playbackSlider.maximumValue = Float(seconds)
           playbackSlider.isContinuous = true
        
        
        audioPlayer!.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main) { (CMTime) -> Void in
                if self.audioPlayer!.currentItem?.status == .readyToPlay {
                    let time : Float64 = CMTimeGetSeconds(self.audioPlayer!.currentTime());
                    self.playbackSlider.value = Float ( time );
                    self.currentDuraation.text = self.stringFromTimeInterval(interval: time)
                }
                let playbackLikelyToKeepUp = self.audioPlayer?.currentItem?.isPlaybackLikelyToKeepUp
                if playbackLikelyToKeepUp == false{
                    print("IsBuffering")
//                    self.ButtonPlay.isHidden = true
                    //        self.loadingView.isHidden = false
                } else {
                    //stop the activity indicator
                    print("Buffering completed")
//                    self.ButtonPlay.isHidden = false
                    //        self.loadingView.isHidden = true
                }
            }
        
        playbackSlider.addTarget(self, action: #selector(playbackSliderValueChanged(_:)), for: .valueChanged)
        audioPlayer!.play()

          //check player has completed playing audio
//          NotificationCenter.default.addObserver(self, selector: #selector(self.finishedPlaying(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)}
//

    }
    

    @objc func playbackSliderValueChanged(_ playbackSlider:UISlider) {
        let seconds : Int64 = Int64(playbackSlider.value)
        let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
        if isPlayed {
            audioPlayer!.seek(to: targetTime)
            if audioPlayer!.rate == 0 {
                audioPlayer?.play()
            }
        }
       
    }
    
    
    @objc func finishedPlaying( _ myNotification:NSNotification) {
        playButton.setImage(UIImage(named: "play"), for: UIControl.State.normal)
        //reset player when finish
        playbackSlider.value = 0
        let targetTime:CMTime = CMTimeMake(value: 0, timescale: 1)
        audioPlayer!.seek(to: targetTime)
    }

    @IBAction func playButton(_ sender: Any) {
        print("play Button")
        if audioPlayer?.rate == 0
        {
            audioPlayer!.play()
//            self.ButtonPlay.isHidden = true
            //        self.loadingView.isHidden = false
            
            playButton.setImage(UIImage(systemName: "pause"), for: UIControl.State.normal)
        } else {
            audioPlayer!.pause()
            playButton.setImage(UIImage(systemName: "play"), for: UIControl.State.normal)
        }
        
    }


    func stringFromTimeInterval(interval: TimeInterval) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }



    @IBAction func seekBackWards(_ sender: Any) {
        if audioPlayer == nil { return }
        let playerCurrenTime = CMTimeGetSeconds(audioPlayer!.currentTime())
        var newTime = playerCurrenTime - seekDuration
        if newTime < 0 { newTime = 0 }
        audioPlayer?.pause()
        let selectedTime: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
        audioPlayer?.seek(to: selectedTime)
        audioPlayer?.play()

    }


    @IBAction func seekForward(_ sender: Any) {
        if audioPlayer == nil { return }
        if let duration = audioPlayer!.currentItem?.duration {
           let playerCurrentTime = CMTimeGetSeconds(audioPlayer!.currentTime())
           let newTime = playerCurrentTime + seekDuration
           if newTime < CMTimeGetSeconds(duration)
           {
              let selectedTime: CMTime = CMTimeMake(value: Int64(newTime * 1000 as
           Float64), timescale: 1000)
              audioPlayer!.seek(to: selectedTime)
           }
           audioPlayer?.pause()
           audioPlayer?.play()
          }
    }

    
    func setupConstraints() {
        rect.snp.makeConstraints { make in
            make.height.equalTo(250)
            make.top.equalTo(image.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        nameSong.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
        
        
        currentDuraation.snp.makeConstraints { make in
            make.top.equalTo(nameSong.snp.bottom).offset(30)

        }
        
        descriptionName.snp.makeConstraints { make in
            make.top.equalTo(currentDuraation.snp.top)
            make.trailing.equalToSuperview().inset(16)
        }
        
        playbackSlider.snp.makeConstraints { make in
            make.top.equalTo(currentDuraation.snp.bottom).offset(10)
            make.width.equalToSuperview()
        }
        
        randomButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalTo(forwardButton.snp.centerY)
        }
        image.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalToSuperview().multipliedBy(0.5)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(50)
        }
        circle.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.height.equalTo(60)
            make.bottom.equalTo(backwardButton)
            make.centerX.equalToSuperview()
        }
        playButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        forwardButton.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(50)
            make.bottom.equalTo(backwardButton)
            make.centerX.equalTo(rect).offset(70)
        }
        
        backwardButton.snp.makeConstraints { make in
            make.centerX.equalTo(rect).offset(-70)
            make.bottom.equalTo(rect).inset(10)
            make.width.equalTo(50)
            make.height.equalTo(50)
            
        }
        listButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(forwardButton.snp.centerY)
        }
       
        
        
    }
    
    
    
    @objc func playAction() {
        if let player = audioPlayer {
            if player.timeControlStatus == .playing {
                let config = UIImage.SymbolConfiguration(
                    pointSize: 30, weight: .medium, scale: .default)
                let image = UIImage(systemName: "play", withConfiguration: config)
                self.isPlayed = false
                playButton.setImage(image, for: .normal)
                
                player.pause()
                print("Asdads")
            } else {
                player.play()
                let config = UIImage.SymbolConfiguration(
                    pointSize: 30, weight: .medium, scale: .default)
                let image = UIImage(systemName: "pause", withConfiguration: config)
                self.isPlayed = true

                playButton.setImage(image, for: .normal)                 }
        }
    }
    
    
    func callToViewModelForUIUpdate() {
        
        self.viewModel = AudioViewModel(with: surah.id!)
        self.viewModel.bindViewModelToController = {
            self.updateDataSource()
        }
        
    }
    
    func updateDataSource(){
        DispatchQueue.main.async {
            self.audio = self.viewModel?.empData
            self.nameSong.text = "\(self.surah.name_simple!)"
            self.loadAudioFile(with: self.audio.audio_url!)

        }
    }
    

}


extension AudioViewController: AudioDelegate {
    func givingObject(_ surah: Surah) {
        self.surah = surah

        callToViewModelForUIUpdate()

    }
    
}
