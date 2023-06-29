//
//  CustomView.swift
//  QuranKZUIKIT2
//
//  Created by Али  on 29.06.2023.
//

import UIKit
import SnapKit

class CustomView: UIView {
    
    private var text: String?
    
    lazy private var greenRect: UIView = {
       let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    lazy private var image: UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: "clock")
        let screenSize: CGRect = UIScreen.main.bounds
        iv.frame = CGRect(x: 0, y: 0, width: 50, height: screenSize.height * 0.2)
        iv.transform = iv.transform.rotated(by: .pi * 1.97)
        iv.layer.opacity = 0.3
        return iv
    }()
    
    lazy private var firstText: UILabel = {
       let label = UILabel()
        label.text = "adsasddas"
        label.font = Font.shared.basic
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy private var arrowRight: UIImageView = {
       let label = UIImageView()
//        label.font = Font.shared.basic
        label.tintColor = UIColor(red: 0.49, green: 0.29, blue: 0.25, alpha: 1.00)
        let configuration = UIImage.SymbolConfiguration(pointSize: 50)
        let image = UIImage(systemName: "chevron.right", withConfiguration: configuration)
        label.image = image
        return label
    }()
    
    init(frame: CGRect, text: String, color: UIColor, image: UIImage) {
        super.init(frame: frame)
        
        self.greenRect.backgroundColor = color
        self.firstText.text = text
        self.image.image = image
        addSubview(greenRect)
        greenRect.addSubview(firstText)
        greenRect.addSubview(arrowRight)
        greenRect.addSubview(self.image)
        
        setupConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        
        greenRect.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(120)
            make.top.bottom.equalToSuperview()
        }
        firstText.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        arrowRight.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        image.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.3)
            make.height.equalToSuperview().multipliedBy(0.9)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(-30)
      
        }
    }
    
}
