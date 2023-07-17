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
    
    var selectedIndex: IndexPath?

    
    
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
        collectionView.allowsMultipleSelection = false

        return collectionView
    }()
    
    func callToViewModelForUIUpdate() {
        
        viewModel = SurahViewModel()
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

        // Reset the cell's state
        UIView.transition(with: cell, duration: 0.8, options: .transitionCrossDissolve, animations: { [self] in
            cell.label.textColor = (indexPath == selectedIndex) ? UIColor(red: 0.30, green: 0.64, blue: 0.58, alpha: 1.00) : .black
            cell.line.isHidden = (indexPath == selectedIndex) ? false : true
            }, completion: nil)
        
      
        

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Store the selected index
        selectedIndex = indexPath

        guard let cell = collectionView.cellForItem(at: indexPath) as? SurahCollectionViewCell else { return }
        
        cell.label.textColor = UIColor(red: 0.30, green: 0.64, blue: 0.58, alpha: 1.00)
        cell.line.isHidden = false

        
        UIView.transition(with: cell, duration: 0.5, options: .transitionCrossDissolve, animations: {
            cell.label.textColor = UIColor(red: 0.30, green: 0.64, blue: 0.58, alpha: 1.00)
            cell.line.isHidden = false
              // Additional changes for unselected state
          }, completion: nil)

        delegate?.showTheSurah(arrayOfSurahs[indexPath.row])
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? SurahCollectionViewCell else { return }
        
        UIView.transition(with: cell, duration: 0.5, options: .transitionCrossDissolve, animations: {
            cell.label.textColor = .black
            cell.line.isHidden = true
              // Additional changes for unselected state
          }, completion: nil)
    
        // Remove the selected index if it is deselected
        
        if selectedIndex == indexPath {
            selectedIndex = nil
        }

    }
}
