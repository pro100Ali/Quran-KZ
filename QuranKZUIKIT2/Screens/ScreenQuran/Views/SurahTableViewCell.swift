//
//  TableViewCell.swift
//  QuranKZUIKIT2
//
//  Created by Али  on 15.07.2023.
//

import UIKit
import SnapKit

class SurahTableViewCell: UITableViewCell {
    
    lazy private  var text: UILabel = {
        let text = UILabel()
        text.text = "Hello"
        text.textColor = .gray
        return text
    }()
    
    lazy private var textArabic: UILabel = {
        let text = UILabel()
        text.text = ""
        text.numberOfLines = 0
        text.sizeToFit()
        text.textColor = UIColor(red: 0.30, green: 0.64, blue: 0.58, alpha: 1.00)
        text.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return text
    }()
    
    var arabicText: UILabel = {
        let text = UILabel()
        text.text = ""
        
        text.numberOfLines = 0
        
        text.sizeToFit()
        return text
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(text)
        addSubview(textArabic)
        addSubview(arabicText)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(_ word: SurahVerses) {
        
        self.textArabic.text! = ""
        self.arabicText.text! = ""
        self.text.text = word.verse_key
    
        for i in word.words! {
            if let word2 = i.transliteration?.text {
                self.textArabic.text! += "  \(word2.uppercased())"
            }
            if let word1 = i.translation?.text {
                self.arabicText.text! += " \(word1.uppercased())"
            }
        }
    }
    
    func setupConstraints() {
        text.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(20)
        }
        textArabic.snp.makeConstraints { make in
            make.top.equalTo(text.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)

            
        }
        arabicText.snp.makeConstraints { make in
            make.top.equalTo(textArabic.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
        }
    }
}
