//
//  DemoSurahViewController.swift
//  QuranKZUIKIT2
//
//  Created by Али  on 28.06.2023.
//

import UIKit
import SnapKit

protocol EachSurah: AnyObject {
    func showTheSurah(_ id: Int)
}

class DemoSurahViewController: UIViewController {
    
    var delegate: SurahDelegate?
    var arrayOfSurahs: [Surah] = []
    var surahInfo: SurahInfo?
    
    private var viewModel: SurahViewModel!

    lazy private var mainView: UIView = {
       let view = UIView()
        return view
    }()
    lazy private var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        
        return scroll
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
    
    lazy private var text: UILabel = {
       let label = UILabel()
        label.text = "06-28 16:18:30.441952+0500 QuranKZUIKIT2[28223:3627327] The relevant UICollectionViewFlowLayout instance is <UICollectionViewFlowLayout: 0x14d510c10>, and it is attached to <UICollectionView: 0x14f019e00; frame = (2 0; 393 2); clipsToBounds = YES; gestureRecognizers = <NSArray: 0x6000003c2790>; backgroundColor = <UIDynamicSystemColor: 0x6000018b1180; name = systemBackgroundColor>; layer = <CALayer: 0x600000ddbde0>; contentOffset: {0, 0}; contentSize: {0, 2}; adjustedContentInset: {0, 0, 0, 0}; layout: <UICollectionViewFlowLayout: 0x14d510c10>; dataSource: <QuranKZUIKIT2.DemoSurahViewController: 0x14e82bc00>>."
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    func callToViewModelForUIUpdate() {
        
        self.viewModel =  SurahViewModel()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        callToViewModelForUIUpdate()
        collection.delegate = self
        collection.dataSource = self
        view.addSubview(scrollView)
        scrollView.addSubview(mainView)
        mainView.addSubview(collection)
        mainView.addSubview(text)
        scrollView.delegate = self

        setupConstraints()
//        callToViewModelForUIUpdate()
        
        
        

    }
    
    func setupConstraints() {
    
        scrollView.snp.makeConstraints { make in
            make.width.equalTo(500)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        collection.snp.makeConstraints { make in
            make.width.equalTo(view.snp.width)
            make.leading.trailing.equalToSuperview().inset(2)
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        text.snp.makeConstraints { make in
            make.top.equalTo(collection.snp.bottom).offset(20)
            make.width.equalTo(view.snp.width)
            make.height.equalToSuperview()
            
        }
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    

}

extension DemoSurahViewController: UICollectionViewDataSource, UICollectionViewDelegate {
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

        APICaller.shared.getInfoChapters(with: arrayOfSurahs[indexPath.row].id!) { res in
            switch res {
            case .success(let success):
                    DispatchQueue.main.async {
                        self.text.text = success.short_text
                }
            case .failure(let failure):
                print(failure)
            }
        }


    }
}
