//
//  UTableViewCell.swift
//  QuranKzUIKit
//
//  Created by Али  on 18.06.2023.
//

import UIKit
import SnapKit

class SurahTableViewCell: UITableViewCell {
    lazy  var label: UILabel = {
        let label = UILabel()
        label.text = "Al Fatiha"
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupConstraints() {
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
