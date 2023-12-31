//
//  BookCell.swift
//  QuranKZUIKIT2
//
//  Created by Али  on 09.07.2023.
//

import UIKit
import SnapKit
import SDWebImage
import SkeletonView


class BookCell: UICollectionViewCell {

    lazy private var rect: UIView = {
       let rect = UIView()
        rect.backgroundColor = .lightGray
        rect.layer.cornerRadius = 10
        rect.isSkeletonable = true
        rect.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .concrete), animation: nil, transition: .crossDissolve(0.25))
        return rect
    }()
    
    lazy private var image: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "bookQuran")
        image.backgroundColor = .red
        image.isSkeletonable = true
        return image
    }()
    
    lazy private var titleOfBook: UILabel = {
       let label = UILabel()
        label.text = "Title of Book"
        label.numberOfLines = 0
        label.sizeToFit()
        label.textAlignment = .center
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(rect)
        rect.addSubview(image)
        addSubview(titleOfBook)
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        rect.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        image.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        titleOfBook.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(image.snp.width)
        }
    }
    
    func configure(_ book: Book) {
        self.titleOfBook.text = book.name
        self.image.sd_setImage(with: URL(string:book.image))
        [self.rect, self.image].forEach {
            $0.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
            $0.stopSkeletonAnimation()
        }
        print(URL(string:book.image))
    }
}
