//
//  HeaderView.swift
//  QuranKZUIKIT2
//
//  Created by Али  on 14.07.2023.
//

import UIKit
import SnapKit

class HeaderView: UIView {
    
    var arrayOfSurahs: [Surah] = []
    var delegate: EachSurah?
    
    private var viewModel: SurahViewModel!

    lazy private var mainView: UIView = {
       let view = UIView()
        return view
    }()

    
    lazy private var collection: UICollectionView  = {
       let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 50)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SurahCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    func callToViewModelForUIUpdate() {
        
        self.viewModel = SurahViewModel()
        self.viewModel.bindViewModelToController = {
        self.updateDataSource()
        }
        
    }
    
    func updateDataSource(){
           DispatchQueue.main.async {
               self.arrayOfSurahs = self.viewModel.empData
               self.collection.reloadData()
           }
       }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        callToViewModelForUIUpdate()
        collection.delegate = self
        collection.dataSource = self
        addSubview(collection)
        setupConstraints()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
    
        collection.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(2)
            make.height.equalToSuperview()
        }
    }
    


}

extension HeaderView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfSurahs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SurahCollectionViewCell else { return UICollectionViewCell() }
        cell.label.text = arrayOfSurahs[indexPath.row].name_simple
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SurahCollectionViewCell

//        APICaller.shared.getInfoChapters(with: arrayOfSurahs[indexPath.row].id!) { res in
//            switch res {
//            case .success(let success):
//                    DispatchQueue.main.async {
//
//                        self.text.text = success[indexPath.row].verse_key
//                }
//            case .failure(let failure):
//                print(failure)
//            }
//        }
      
        delegate?.showTheSurah(arrayOfSurahs[indexPath.row])

    }
}
