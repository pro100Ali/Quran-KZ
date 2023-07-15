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
        return text
    }()
    
    lazy private var textArabic: UILabel = {
        let text = UILabel()
        text.text = ""
        text.numberOfLines = 0
        text.sizeToFit()
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
        }
        textArabic.snp.makeConstraints { make in
            make.top.equalTo(text.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(16)
            make.width.equalToSuperview()
            
        }
        arabicText.snp.makeConstraints { make in
            make.top.equalTo(textArabic.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(16)
            make.width.equalToSuperview()
        }
    }
}
