//
//  TimeViewController.swift
//  QuranKZUIKIT2
//
//  Created by Али  on 20.06.2023.
//

import UIKit
import SnapKit

class TimeViewController: UIViewController {
    
    private var time = Date()

    private var viewModel: SurahTimeViewModel!
    
    private var currentSura: NameSurah!
    

    
    lazy private var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.shared.isha
        return view
    }()
    
    
    lazy private var commonView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    
    let sunView = SunView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))

    
    var fajrTime = TimeView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), name:
                                "Tan", color: Color.shared.fajr)
    
    var sunriseTime = TimeView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), name:
                                "Kun", color: Color.shared.sunrise)
    
    var dhuhrTime = TimeView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), name:
                                "Besin", color: Color.shared.dhuhr)
    
    var asrTime = TimeView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), name:
                            "Ekinti", color: Color.shared.asr)
    
    var maghribTime = TimeView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), name:
                                "Sham", color: Color.shared.maghrib)
    
    var ishaTime = TimeView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), name:
                                "Kuptan", color: Color.shared.isha)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.shared.dhuhr
//        currentSura = .besin
        
     
        view.addSubview(mainView)
        mainView.addSubview(sunView)

        mainView.addSubview(commonView)
        
        [fajrTime, sunriseTime, dhuhrTime, asrTime, maghribTime, ishaTime].forEach{ commonView.addSubview($0) }
        callToViewModelForUIUpdate()
        setupConstraints()
        navigationController?.navigationBar.tintColor = UIColor.white
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeTheView(_:)), name: Notification.Name("colorChanged"), object: nil)
   
        switch currentSura {
        case .tan:
            mainView.backgroundColor = Color.shared.fajr
        case .kun:
            mainView.backgroundColor = Color.shared.sunrise
        case .besin:
            mainView.backgroundColor = Color.shared.dhuhr
        case .ekinti:
            mainView.backgroundColor = Color.shared.asr
        case .sham:
            mainView.backgroundColor = Color.shared.maghrib
        case .kuptan:
            mainView.backgroundColor = Color.shared.isha
        case .none:
            mainView.backgroundColor = Color.shared.isha

        }
    }
    
    @objc func changeTheView(_ notification: NSNotification) {
        if let dict = notification.userInfo as NSDictionary? {
            if let name = dict["currentSurah"] as? NameSurah {
                self.currentSura = name
                print(currentSura)
                switch currentSura {
                case .tan:
                    mainView.backgroundColor = Color.shared.fajr
                case .kun:
                    mainView.backgroundColor = Color.shared.sunrise
                case .besin:
                    mainView.backgroundColor = Color.shared.dhuhr
                case .ekinti:
                    mainView.backgroundColor = Color.shared.asr
                case .sham:
                    mainView.backgroundColor = Color.shared.maghrib
                case .kuptan:
                    mainView.backgroundColor = Color.shared.isha
                case .none:
                    mainView.backgroundColor = Color.shared.isha

                }
                NotificationCenter.default.removeObserver(self)

            }
        }
    }
    
    
    @objc func callToViewModelForUIUpdate() {
        
        self.viewModel = SurahTimeViewModel()
        self.viewModel.bindViewModelToController = {
             self.updateDataSource()
        }
        
        self.viewModel.changeBack = {
            self.currentSura = self.viewModel.currentSurah
            print(self.currentSura as Any)
        }
        
    }
    
    @objc func updateDataSource() {
        
        self.configureTheApi(self.viewModel.empData)
        sunView.configure(viewModel.array)
    }
    
    

    
    func configureTheApi(_ element: Time) {
        self.fajrTime.configure(time: element.bamdat!)
        self.sunriseTime.configure(time: element.kun!)
        self.dhuhrTime.configure(time: element.besin!)
        self.asrTime.configure(time: element.ekindi!)
        self.maghribTime.configure(time: element.aqsham!)
        self.ishaTime.configure(time: element.quptan!)
        viewModel.configureArray()
    }
    
    
    func setupConstraints() {
        sunView.snp.makeConstraints { make in
//                        make.height.equalTo(50)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().inset(150)
            make.top.equalToSuperview().inset(90)
        }
        mainView.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        commonView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.3)
            make.trailing.equalToSuperview()
        }
        
        fajrTime.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.17)
            make.top.equalToSuperview()
        }
        
        
        sunriseTime.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.17)
            make.top.equalTo(fajrTime.snp.bottom)
            
        }
        
        dhuhrTime.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.17)
            make.top.equalTo(sunriseTime.snp.bottom)
        }
        
        asrTime.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.17)
            make.top.equalTo(dhuhrTime.snp.bottom)
        }
        
        maghribTime.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.17)
            make.top.equalTo(asrTime.snp.bottom)
        }
        ishaTime.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.17)
            make.top.equalTo(maghribTime.snp.bottom)
        }

    }
    
}
