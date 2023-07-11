//
//  VideoTableViewCell.swift
//  QuranKZUIKIT2
//
//  Created by Али  on 11.07.2023.
//

import UIKit
import SnapKit

class TutCell: UICollectionViewCell {
 
    var video: Video! {
        didSet {
            updateUI()
        }
    }
    
    
    lazy private var poster: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "clock")
        return image
    }()
    
    lazy var label: UILabel = {
       let label = UILabel()
        label.text = "video 1"
        label.tintColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        return label
    }()
    
    lazy var desc: UILabel = {
        let label = UILabel()
        label.text = "Ерлерге арналған Ханафи мәзһабы бойынша таң (фәжр) намазының 2 ракәғат парызы.Құранның және барлық мазмұнның кәсіби дыбысталуы, сондай-ақ жедел транскрипциясы мен аудармасы."
        label.textColor = .gray
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(poster)
        addSubview(label)
        addSubview(desc)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupConstraints() {
        poster.snp.makeConstraints { make in
            make.height.equalTo(80)
            make.width.equalTo(150)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }
        label.snp.makeConstraints { make in
            make.leading.equalTo(poster.snp.trailing).offset(10)
            make.top.equalTo(poster.snp.top)
        }
        desc.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(5)
            make.leading.equalTo(label)
            make.trailing.equalToSuperview().inset(10)
        }
    }
    
    func updateUI() {
        label.text = video.name
        poster.image = UIImage(named: video.image)
        desc.text = video.desc
    }
}
