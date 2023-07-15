//
//  HeaderForTable.swift
//  QuranKZUIKIT2
//
//  Created by Али  on 16.07.2023.
//

import UIKit
import SnapKit

class HeaderForTable: UIView {
    
    lazy private var view: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy private var label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "الفاتحة"
        label.font = UIFont.systemFont(ofSize: 35, weight: .light)

        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(view)
        view.addSubview(label)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(_ str: String) {
        label.text = str
    }
    func setupConstraints() {
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
