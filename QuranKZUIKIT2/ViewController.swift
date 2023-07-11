//
//  ViewController.swift
//  QuranKzUIKit
//
//  Created by Али  on 17.06.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
//
//    lazy private var greenRect: UIView = {
//       let view = UIView()
//        view.backgroundColor = UIColor(red: 0.33, green: 0.73, blue: 0.62, alpha: 1.00)
//        return view
//    }()
    
//    lazy private var redRect: UIView = {
//       let view = UIView()
//        view.backgroundColor = UIColor(red: 0.93, green: 0.45, blue: 0.37, alpha: 1.00)
//        return view
//    }()
//    lazy private var purpleRect: UIView = {
//       let view = UIView()
//        view.backgroundColor = UIColor(red: 0.60, green: 0.40, blue: 0.71, alpha: 1.00)
//        return view
//    }()
//
//    lazy private var yellowRect: UIView = {
//       let view = UIView()
//        view.backgroundColor = UIColor(red: 0.96, green: 0.80, blue: 0.33, alpha: 1.00)
//
//        return view
//    }()
//
//    lazy private var blueRect: UIView = {
//       let view = UIView()
//        view.backgroundColor = UIColor(red: 0.30, green: 0.67, blue: 0.82, alpha: 1.00)
//        return view
//    }()
    
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
//        greenRect.addSubview(firstText)
//        redRect.addSubview(timeText)
//        purpleRect.addSubview(bookText)
//        yellowRect.addSubview(suraText)
//        setupConstraints()
        
//        view.addSubview(gr    eenRect)
        
     
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
        print("You clicked on view")
        let vc = DemoSurahViewController()
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
        let vc = AudioViewController()
        navigationController?.present(vc, animated: true)
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

