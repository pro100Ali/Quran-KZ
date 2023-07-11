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
//    var audioPlayer: AVAudioPlayer?
    
    var audio: Audio?
    var currentAudio: String = "a1"
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
        let image = UIImage(systemName: "play", withConfiguration: config)
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
        label.text = "Rose Imanbek"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return label
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        [rect, image].forEach { view.addSubview($0) }
        circle.addSubview(playButton)
        [nameSong, descriptionName, circle, backwardButton, forwardButton, randomButton, listButton].forEach { rect.addSubview($0) }
        setupConstraints()

//        loadAudioFile()
        
        
    }

    func setupConstraints() {
        rect.snp.makeConstraints { make in
            make.height.equalTo(250)
            make.top.equalTo(image.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(16)
        }
   
        nameSong.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(16)
        }
        descriptionName.snp.makeConstraints { make in
            make.top.equalTo(nameSong.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(16)
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
            make.bottom.equalTo(rect).inset(30)
            make.width.equalTo(50)
            make.height.equalTo(50)

        }
        listButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(forwardButton.snp.centerY)
        }
  
        
    }
    
    func loadAudioFile(_ audio: String) {
        guard let audioURL = Bundle.main.url(forResource: audio, withExtension: "mp3") else {
            return
        }
        audioPlayer = AVPlayer(url: audioURL)
    }
    
    @objc func playAction() {
        if let player = audioPlayer {
            if player.timeControlStatus == .playing {
                let config = UIImage.SymbolConfiguration(
                    pointSize: 30, weight: .medium, scale: .default)
                let image = UIImage(systemName: "play", withConfiguration: config)
                playButton.setImage(image, for: .normal)
                player.pause()

            } else {
                player.play()
                    let config = UIImage.SymbolConfiguration(
                        pointSize: 30, weight: .medium, scale: .default)
                    let image = UIImage(systemName: "pause", withConfiguration: config)
                    playButton.setImage(image, for: .normal)                 }
        }
    }

    
    func play() {
        if let player = audioPlayer {
            player.play()
        }
    }

    func pause() {
        if let player = audioPlayer {
            player.pause()
        }
    }

//    func stop() {
//        if let player = audioPlayer {
//            player.stop()
////            player.currentTime = 0 // Reset playback position
//        }
//    }
}


extension AudioViewController: AudioDelegate {
    func givingObject(_ audio: Audio) {
        
            self.nameSong.text = audio.name
            self.descriptionName.text = audio.desc
            self.currentAudio = audio.audioFileName
            loadAudioFile(audio.audioFileName)
    }
    
}
