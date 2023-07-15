//
//  TimeView.swift
//  QuranKZUIKIT2
//
//  Created by Али  on 02.07.2023.
//

import UIKit
import SnapKit

class TimeView: UIView {

    lazy private var rectColor: UIView = {
       let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    
    lazy private var timeText: UILabel = {
       let view = UILabel()
        view.text = "12:00"
        view.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        view.textColor = .white
        return view
    }()
    
    lazy private var nameText: UILabel = {
       let view = UILabel()
        view.text = "Ekinti"
        view.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        view.textColor = .white
        return view
    }()
    
    init(frame: CGRect, name: String, color: UIColor) {
        super.init(frame: frame)
        self.nameText.text = name
        self.rectColor.backgroundColor = color
        addSubview(rectColor)
        rectColor.addSubview(nameText)
        rectColor.addSubview(timeText)
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(time: String) {
        self.timeText.text = time
    }
    func setupConstraints() {
        rectColor.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        nameText.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.centerX.equalToSuperview()

        }
        timeText.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
    }
    

}
