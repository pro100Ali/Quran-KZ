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
    
    var audioPlayer: AVAudioPlayer?
    private var isPlayed = true
    
    lazy private var rect: UIView = {
       let rect = UIView()
        rect.layer.cornerRadius = 15
        rect.backgroundColor = .gray
    return rect
    }()
    
    lazy private var circle: UIView = {
       let circle = UIView()
        circle.layer.cornerRadius = 30
        circle.backgroundColor = UIColor(red: 0.19, green: 0.30, blue: 0.53, alpha: 1.00)
        return circle
    }()
    
    lazy private var playButton: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
        let config = UIImage.SymbolConfiguration(
        pointSize: 30, weight: .medium, scale: .default)
        let image = UIImage(systemName: "play", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(play), for: .touchUpInside)
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
    
    private var durationSlider: UISlider!
        private var currentTimeLabel: UILabel!
    
    
    @objc func sliderValueChanged(_ slider: UISlider) {
         let duration = slider.value
         let formattedTime = formatTime(duration)
         currentTimeLabel.text = formattedTime
     }
     
     func formatTime(_ duration: Float) -> String {
         let minutes = Int(duration) / 60
         let seconds = Int(duration) % 60
         return String(format: "%d:%02d", minutes, seconds)
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

                durationSlider = UISlider()
              durationSlider.minimumValue = 0
              durationSlider.maximumValue = 100
              durationSlider.value = 0
              durationSlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
              
              // Create the current time label
              currentTimeLabel = UILabel()
              currentTimeLabel.text = "0:00"
              
              // Add the slider and label to the view
              rect.addSubview(durationSlider)
              rect.addSubview(currentTimeLabel)
              
       
         
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set up audio session: \(error)")
        }
        [rect, image].forEach { view.addSubview($0) }
        circle.addSubview(playButton)
        [nameSong, descriptionName, circle, backwardButton, forwardButton, randomButton, listButton].forEach { rect.addSubview($0) }
        setupConstraints()
        loadAudioFile()
        
        
    }
    func setupConstraints() {
        rect.snp.makeConstraints { make in
            make.height.equalTo(250)
            make.top.equalTo(image.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        durationSlider.snp.makeConstraints { make in
            make.top.equalTo(descriptionName.snp.bottom).offset(32)
        }
        currentTimeLabel.snp.makeConstraints { make in
            make.bottom.equalTo(durationSlider.snp.top)
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
    func loadAudioFile() {
        guard let audioFilePath = Bundle.main.path(forResource: "audio", ofType: "mp3") else {
            print("Audio file not found")
            return
        }

        let audioFileURL = URL(fileURLWithPath: audioFilePath)

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFileURL)
            audioPlayer?.prepareToPlay()
        } catch {
            print("Failed to load audio file: \(error)")
        }
    }
    
    @objc func play() {
        if let player = audioPlayer {
            if isPlayed {
                player.play()
                let config = UIImage.SymbolConfiguration(
                    pointSize: 30, weight: .medium, scale: .default)
                let image = UIImage(systemName: "pause", withConfiguration: config)
                playButton.setImage(image, for: .normal)            }
            else {
                player.pause()
                let config = UIImage.SymbolConfiguration(
                    pointSize: 30, weight: .medium, scale: .default)
                let image = UIImage(systemName: "play", withConfiguration: config)
                playButton.setImage(image, for: .normal)
            }
            isPlayed.toggle()
            
        }
    }

    func pause() {
        if let player = audioPlayer {
            player.pause()
        }
    }

    func stop() {
        if let player = audioPlayer {
            player.stop()
            player.currentTime = 0 // Reset playback position
        }
    }


}
