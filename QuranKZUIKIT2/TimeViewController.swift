//
//  TimeViewController.swift
//  QuranKZUIKIT2
//
//  Created by Али  on 20.06.2023.
//

import UIKit
import SnapKit

class TimeViewController: UIViewController {
    private var array: [Time] = [Time]()
    private var time = Date()
    
    lazy private var commonView: UIView = {
       let view = UIView()
        view.backgroundColor = .gray
        return view
    }()

    
    lazy private var fajrTime: UILabel = {
       let text = UILabel()
       text.text = "02:07"
        text.backgroundColor = Color.shared.fajr
       return text
    }()
    
    
    lazy private var sunriseTime: UILabel = {
       let text = UILabel()
       text.text = "02:07"
        text.backgroundColor = Color.shared.sunrise
       return text
    }()
    

    
    lazy private var dhuhrTime: UILabel = {
       let text = UILabel()
       text.text = "02:07"
        text.backgroundColor = Color.shared.dhuhr
       return text
    }()
    
    
    lazy private var asrTime: UILabel = {
       let text = UILabel()
       text.text = "02:07"
        text.backgroundColor = Color.shared.asr
       return text
    }()
    
    lazy private var maghribTime: UILabel = {
       let text = UILabel()
       text.text = "02:07"
        text.backgroundColor = Color.shared.maghrib
       return text
    }()
    
    lazy private var ishaTime: UILabel = {
       let text = UILabel()
       text.text = "02:07"
        text.backgroundColor = Color.shared.isha
       return text
    }()
    
    lazy private var remainingTime: UILabel = {
       let text = UILabel()
       text.text = "00:52"
        text.backgroundColor = .white
       return text
    }()

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(commonView)
        view.addSubview(remainingTime)
        
        [fajrTime, sunriseTime, dhuhrTime, asrTime, maghribTime, ishaTime].forEach{ commonView.addSubview($0) }
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let currentTime = dateFormatter.string(from: Date())

        print("Current time: \(currentTime)")
        
        setupConstraints()
        
        APICaller.shared.getTimePray { res in
            switch res {
            case .success(let success):

                DispatchQueue.main.async {
                    self.array = success
                    print(self.array[3].Asr)
                    
                    let desiredDate = "01-01-2023"

                    if let element = self.array.first(where: { $0.date == desiredDate }) {
                        print(element)
                        self.configureTheApi(element)
                        
                    } else {
                        print("Element not found in the array.")
                    }
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func configureTheApi(_ element: Time) {
        self.fajrTime.text = element.Fajr
        self.sunriseTime.text = element.Sunrise
        self.dhuhrTime.text = element.Dhuhr
        self.maghribTime.text = element.Maghrib
        self.ishaTime.text = element.Isha
        self.asrTime.text = element.Asr
    }
    
    func setupConstraints() {
        commonView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalToSuperview().multipliedBy(0.3)
            make.trailing.equalToSuperview()
        }

        fajrTime.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.15)
            make.top.equalToSuperview()
        }
        
       
        sunriseTime.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.15)
            make.top.equalTo(fajrTime.snp.bottom)
            
        }
        
        dhuhrTime.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.15)
            make.top.equalTo(sunriseTime.snp.bottom)
        }
        
        asrTime.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.15)
            make.top.equalTo(dhuhrTime.snp.bottom)
        }
        
        maghribTime.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.15)
            make.top.equalTo(asrTime.snp.bottom)
        }
        ishaTime.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.15)
            make.top.equalTo(maghribTime.snp.bottom)
        }
        remainingTime.snp.makeConstraints { make in
//            make.width.equalTo(50)
            make.height.equalTo(50)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().inset(150)
            make.centerY.equalToSuperview()
        }
        
        
        
    }
    
}
