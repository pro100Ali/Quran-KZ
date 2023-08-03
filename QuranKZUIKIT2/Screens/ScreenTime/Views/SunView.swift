//
//  SunView.swift
//  QuranKZUIKIT2
//
//  Created by Али  on 02.07.2023.
//

import UIKit
import SnapKit

enum NameSurah {
    case tan
    case kun
    case besin
    case ekinti
    case sham
    case kuptan
}

protocol ChangingView {
    func changeTheView(_ current: NameSurah)
}


class SunView: UIView {
    
//    var viewModel: SurahTimeViewModel = SurahTimeViewModel()
    var isFirst = true
    var delegate: ChangingView?
    var currentSura: NameSurah!
    
    var changeBack: (() -> ()) = {}
    
    var namazTimes: [String] = []

    var timer: Timer?

    lazy private var backColor: UIView = {
       let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    lazy private var theSun: UIImageView = {
        let text = UIImageView()
        text.image = UIImage(systemName: "sun.and.horizon")
        text.tintColor = .white
        text.contentMode = .scaleAspectFit
        return text
    }()
    
    lazy private var textLabel: UILabel = {
        let text = UILabel()
        text.text = "Уақыттың шығуы".uppercased()
        text.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        text.textColor = .white

        return text
    }()
    
    lazy private var timeLabel: UILabel = {
       let text = UILabel()
        text.text = "00:00:00"
        text.textColor = .white
        text.font = UIFont.systemFont(ofSize: 35, weight: .semibold)

        return text
    }()
    
    lazy private var line: UIView = {
       let text = UIView()
        text.backgroundColor = .white
        return text
    }()
    
    
    lazy private var randomDuga: UILabel = {
       let text = UILabel()
        text.numberOfLines = 0
        text.lineBreakMode = .byWordWrapping
        text.text = "Құран.кз топтамасында Құран Кәрімнің қазақ тіліне аудармасы, «Дұғалар жинағы» кітабы, «Таңғы кешкі дұғалар» кітабы, «Намаз оқып үйренейік» кітаптары ..."
        text.textColor = .white
        return text
    }()
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backColor)

        backColor.addSubview(theSun)
        backColor.addSubview(timeLabel)
        backColor.addSubview(textLabel)
        backColor.addSubview(line)
        backColor.addSubview(randomDuga)
        setupConstraints()

        checkForCurrentSurah()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureImage(_ image: String) {
        theSun.image = UIImage(systemName: image)
    }
    
    func checkForCurrentSurah() {
        
        switch currentSura {
        case .tan:
            currentSura = .kun
        case .kun:
            currentSura = .besin
        case .besin:
            currentSura = .ekinti
        case .ekinti:
            currentSura = .sham
        case .sham:
            currentSura = .kuptan
        case .kuptan:
            currentSura = .tan
        case .none:
            currentSura = .tan
        }
        
    }
    
    func configure(_ namazTimes: [String]) {
        
        self.namazTimes = namazTimes
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateRemainingTime), userInfo: namazTimes, repeats: true)

    }
    
    @objc func updateRemainingTime(timer: Timer) {
          guard let namazTimes = timer.userInfo as? [String] else {
              return
          }
          
        DispatchQueue.main.async { [self] in
            let remainingTime = getNextNamazTime(namazTimes: namazTimes)
            timeLabel.text = "\(remainingTime)"
        }
          
      }
    
    
    deinit {
          timer?.invalidate()
      }
  
    
    func getNextNamazTime(namazTimes: [String]) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = TimeZone(identifier: "UTC+05:00")
        let utcOffsetInSeconds = 5 * 60 * 60  // Convert 5 hours to seconds
        let currentTime2 = Date()
        let currentTime = currentTime2.addingTimeInterval(TimeInterval(utcOffsetInSeconds))
        var currentNamazTime2: [Date] = []
        for timeString in namazTimes {
            var formattedTimeString = timeString
            
            // Handle the case when the time has the "*0:02" format
            if formattedTimeString.hasPrefix("*") {
                formattedTimeString.removeFirst()
            }
            
            if let originalDate = dateFormatter.date(from: formattedTimeString) {
                let calendar = Calendar.current
                
                let originalHour = calendar.component(.hour, from: originalDate)
                let originalMinute = calendar.component(.minute, from: originalDate)
                let originalSecond = calendar.component(.second, from: originalDate)
                
                let currentYear = calendar.component(.year, from: currentTime)
                let currentMonth = calendar.component(.month, from: currentTime)
                let currentDay = calendar.component(.day, from: currentTime)
                
                var newDateComponents = DateComponents()
                newDateComponents.year = currentYear
                newDateComponents.day = currentDay
                newDateComponents.month = currentMonth
                newDateComponents.hour = originalHour
                newDateComponents.minute = originalMinute
                newDateComponents.second = originalSecond
                
                if let newDate = calendar.date(from: newDateComponents) {
                    currentNamazTime2.append(newDate.addingTimeInterval(TimeInterval(5*60*60)))
                } else {
                    print("Failed to create a new date for time: \(timeString)")
                }
            } else {
                print("Failed to convert string to date: \(timeString)")
            }
        }
     
        var nextNamazTime: Date
        
        if timeLabel.text == "00:00:00" {
            switch currentSura {
            case .tan:
                currentSura = .kun
            case .kun:
                currentSura = .besin
            case .besin:
                currentSura = .ekinti
            case .ekinti:
                currentSura = .sham
            case .sham:
                currentSura = .kuptan
            case .kuptan:
                currentSura = .tan
            case .none:
                currentSura = .tan
            }
            
            DispatchQueue.main.async { [self] in
                delegate?.changeTheView(currentSura)
            }
            
        }
        
        if let nextTime = currentNamazTime2.first(where: { $0 > currentTime  }) {
             nextNamazTime = nextTime

             // Find the index of the next namaz time
             
         } else {
             // The next namaz time is the first namaz of the next day
             nextNamazTime = currentNamazTime2[0]
             // Assign the current sura based on the index
             currentSura = getSuraFromIndex(0)
         }
                                                                
        let remainingTime = nextNamazTime.timeIntervalSince(currentTime)
        let hours = Int(remainingTime) / 3600
        let minutes = (Int(remainingTime) % 3600) / 60
        let seconds = Int(remainingTime) % 60
        
        
        if remainingTime <= 0 {
            // Handle the change to the next namaz time here
            // You can update the current namaz time, trigger a callback, or perform any other necessary action
            // For example, you can set the current namaz time to the next namaz time
            let index = currentNamazTime2.firstIndex(of: nextNamazTime)
            if let nextIndex = index?.advanced(by: 1), nextIndex < currentNamazTime2.count {
                nextNamazTime = currentNamazTime2[nextIndex]
            } else {
                // The next namaz time is the first namaz of the next day
                let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: nextNamazTime)!
                nextNamazTime = Calendar.current.date(bySettingHour: currentNamazTime2[0].hour, minute: currentNamazTime2[0].minute, second: 0, of: nextDay)!
                
            }
            
        }
        if let index = currentNamazTime2.firstIndex(of: nextNamazTime) {
            if isFirst {
                currentSura = getSuraFromIndex(index-1)
                DispatchQueue.main.async { [self] in
                    delegate?.changeTheView(currentSura)
                }
                isFirst = false
            }
        
            
        }

        
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    private func getSuraFromIndex(_ index: Int) -> NameSurah {
        switch index {
        case 0:
            return .kuptan
        case 1:
            return .tan
        case 2:
            return .kun
        case 3:
            return .besin
        case 4:
            return .ekinti
        case 5:
            return .sham
        default:
            return .sham
        }
    }
    
    func setupConstraints() {
        
        backColor.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        theSun.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(60)
            make.centerX.equalToSuperview()
        }
        
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(theSun.snp.bottom).offset(15)
            make.leading.equalToSuperview()
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(textLabel.snp.bottom).offset(15)
        }
        line.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(15)
            make.width.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(2)
        }
        randomDuga.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(15)
            make.width.equalToSuperview()
        }
        
    }
}
