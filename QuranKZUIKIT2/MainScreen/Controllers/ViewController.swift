//
//  ViewController.swift
//  QuranKzUIKit
//
//  Created by Али  on 17.06.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    lazy private var firstText: UILabel = {
       let label = UILabel()
        label.text = "Құран"
        label.font = Font.shared.basic
        label.textColor = .white
//        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        return label
    }()
    
    
    lazy private var timeText: UILabel = {
       let label = UILabel()
        label.text = "Уақыт"
        label.font = Font.shared.basic

        label.textColor = .white
        return label
    }()
    
    lazy private var bookText: UILabel = {
       let label = UILabel()
        label.text = "Кітап"
        label.font = Font.shared.basic

        label.textColor = .white
        return label
    }()
    
    
    lazy private var suraText: UILabel = {
       let label = UILabel()
        label.text = "Сұра"
        label.font = Font.shared.basic

        label.textColor = .white
        return label
    }()
    
    let greenRect = CustomView(frame: CGRect(x: 0, y: 0, width: 200, height: 200), text: "Құран", color: Color.shared.greenRect, image: UIImage(named: "twoBook")!)
    
    let redRect = CustomView(frame: CGRect(x: 0, y: 0, width: 200, height: 200), text: "Уақыт", color:  Color.shared.redRect, image: UIImage(named: "clock")!)
    
    let purpleRect = CustomView(frame: CGRect(x: 0, y: 0, width: 200, height: 200), text: "Кітап", color:  Color.shared.purpleRect, image: UIImage(named: "books")!)
    
    let yellowRect = CustomView(frame: CGRect(x: 0, y: 0, width: 200, height: 200), text: "Үйрену", color:  Color.shared.yellowRect, image: UIImage(named: "pray")!)
    
    let blueRect = CustomView(frame: CGRect(x: 0, y: 0, width: 200, height: 200), text: "Құбыла", color:  Color.shared.blueRect, image: UIImage(named: "music")!)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        [greenRect, redRect, purpleRect, yellowRect, blueRect].forEach{ view.addSubview($0) }
        
     
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickSurah(_:)))
        tapGesture.delegate = self
        greenRect.addGestureRecognizer(tapGesture)
        
        let tapTime = UITapGestureRecognizer(target: self, action: #selector(clickTime(_:)))
        tapTime.delegate = self
        redRect.addGestureRecognizer(tapTime)
        
        let tapBook = UITapGestureRecognizer(target: self, action: #selector(clickBook(_:)))
        tapBook.delegate = self
        purpleRect.addGestureRecognizer(tapBook)
        
        let tapAudio = UITapGestureRecognizer(target: self, action: #selector(clickAudio(_:)))
        tapAudio.delegate = self
        blueRect.addGestureRecognizer(tapAudio)
        
        
        let tapTut = UITapGestureRecognizer(target: self, action: #selector(clickTutorial(_:)))
        tapTut.delegate = self
        yellowRect.addGestureRecognizer(tapTut)
        
        setupConstraints()
        
    }
    
 
    @objc func clickSurah(_ sender: UIView) {
        let vc = QuranViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func clickTime(_ sender: UIView) {
        print("You clicked on view")
        let vc = TimeViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func clickBook(_ sender: UIView) {
        print("You clicked on viewBook")
        let vc = BookViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func clickAudio(_ sender: UIView) {
        print("You clicked on audioView")
        let vc = ListAudioViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func clickTutorial(_ sender: UIView) {
        print("You clicked on tut")
        let vc = TutViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupConstraints() {
        greenRect.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalToSuperview()
        }
        
        redRect.snp.makeConstraints { make in
            make.top.equalTo(greenRect.snp.bottom).offset(15)
            make.width.equalToSuperview()
        }
     
        purpleRect.snp.makeConstraints { make in
            make.top.equalTo(redRect.snp.bottom).offset(15)
            make.width.equalToSuperview()
        }
//
        yellowRect.snp.makeConstraints { make in
            make.top.equalTo(purpleRect.snp.bottom).offset(15)
            make.width.equalToSuperview()
        }

        blueRect.snp.makeConstraints { make in
            make.top.equalTo(yellowRect.snp.bottom).offset(15)
            make.width.equalToSuperview()
        }
    }
}

