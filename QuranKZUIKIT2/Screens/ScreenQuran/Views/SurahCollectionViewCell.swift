//
//  SurahCollectionViewCell.swift
//  QuranKZUIKIT2
//
//  Created by Али  on 28.06.2023.
//

import UIKit
import SnapKit

class SurahCollectionViewCell: UICollectionViewCell {
    
    lazy private var rectView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        return view
    }()
    
    var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.layer.cornerRadius = 15
        label.numberOfLines = 2
        //        label.textColor = UIColor(red: 0.30, green: 0.64, blue: 0.58, alpha: 1.00)
        label.textColor = .black
        
        return label
    }()
    
    var line: UIView = {
        let line = UIView()
        line.backgroundColor = Color.shared.greenRect
        line.isHidden = true
        return line
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(rectView)
        
        rectView.addSubview(label)
        rectView.addSubview(line)
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        rectView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
        }
        line.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
            make.height.equalTo(2)
        }
    }
    
    
}
