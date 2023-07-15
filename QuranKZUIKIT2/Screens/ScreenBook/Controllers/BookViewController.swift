//
//  BookViewController.swift
//  QuranKZUIKIT2
//
//  Created by Али  on 09.07.2023.
//

import UIKit
import SnapKit

class BookViewController: UIViewController {
    
    private let spacing:CGFloat = 16.0

    lazy private var collection: UICollectionView  = {
       let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 170)
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BookCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.showsHorizontalScrollIndicator = false
        layout.sectionInset = UIEdgeInsets(top: 30, left: 10, bottom: 50, right: 10)
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
             layout.minimumLineSpacing = 50
//             layout.minimumInteritemSpacing = 100
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collection)
        view.backgroundColor = Color.shared.purpleRect
        setupConstraints()
        collection.delegate = self
        collection.dataSource = self
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func setupConstraints() {
        collection.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
  

}

extension BookViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BookCell
        cell.backgroundColor = .yellow
        cell.layer.cornerRadius = 10
        return cell
    }
    
    
}
