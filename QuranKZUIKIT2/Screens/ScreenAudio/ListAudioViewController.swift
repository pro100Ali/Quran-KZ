//
//  ListAudioViewController.swift
//  QuranKZUIKIT2
//
//  Created by Али  on 12.07.2023.
//

import UIKit

class ListAudioViewController: UIViewController {

    var audios: [Audio] = Audio.fetchAudio()

    
    lazy private var collection: UICollectionView  = {
       let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 400, height: 80)
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(AudioCell.self, forCellWithReuseIdentifier: "cell")
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
        view.backgroundColor = Color.shared.blueRect
        
        collection.delegate = self
        collection.dataSource = self
        setupConstraints()
        // Do any additional setup after loading the view.
    }
    
    func setupConstraints() {
        collection.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.leading.trailing.equalToSuperview()
        }
    }


}


extension ListAudioViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return audios.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AudioCell
        cell.backgroundColor = Color.shared.blueRect
        cell.layer.cornerRadius = 10
        cell.audios = audios[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("asdads")
//        playAudio(at: indexPath)
        let vc = AudioViewController()
        self.present(vc, animated: true, completion: nil)
    }
}
    
