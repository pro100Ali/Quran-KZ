//
//  TutViewController.swift
//  QuranKZUIKIT2
//
//  Created by Али  on 10.07.2023.
//

import UIKit
import SnapKit
import AVKit
import AVFoundation

class TutViewController: UIViewController {

//    let arrayOfVideos: [String] = ["Tan", "Kun", "Besin", "Aksham", "Kuptan"]
    var videos: [Video] = Video.fetchVideos()
    var player = AVPlayer()
    var playerViewController = AVPlayerViewController()
    
    lazy private var collection: UICollectionView  = {
       let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 400, height: 150)
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TutCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.showsHorizontalScrollIndicator = false
        layout.sectionInset = UIEdgeInsets(top: 15, left: 0, bottom: 20, right: 0)
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
             layout.minimumLineSpacing = 20
//             layout.minimumInteritemSpacing = 100
        return collectionView
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collection)
        view.backgroundColor = Color.shared.yellowRect
        
        collection.delegate = self
        collection.dataSource = self
        setupConstraints()
    }
    
    func playVideo(at indexPath: IndexPath) {
        
        let selectedVideo = videos[indexPath.row]
        let videoPath = Bundle.main.path(forResource: selectedVideo.videoFileName, ofType: "mp4")
        print(videoPath)
        let videoPathURL = URL(fileURLWithPath: videoPath!)
        player = AVPlayer(url: videoPathURL)
        playerViewController.player = player
        
        self.present(playerViewController, animated: true)
    }
    
    
    func setupConstraints() {
        collection.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.leading.trailing.equalToSuperview()
        }
    }

}

extension TutViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TutCell
        cell.backgroundColor = Color.shared.yellowRect
        cell.layer.cornerRadius = 10
        cell.video = videos[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("asdads")
        playVideo(at: indexPath)
    }
}
    
