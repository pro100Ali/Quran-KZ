//
//  SurahCollectionViewCell.swift
//  QuranKZUIKIT2
//
//  Created by Али  on 28.06.2023.
//

import UIKit

class SurahCollectionViewCell: UICollectionViewCell {

    
    lazy private var rectView: UIView = {
       let view = UIView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 15
        return view
    }()
    
    var label: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.layer.cornerRadius = 15
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(rectView)
        
        rectView.addSubview(label)
        rectView.frame = contentView.bounds
        label.frame = rectView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
