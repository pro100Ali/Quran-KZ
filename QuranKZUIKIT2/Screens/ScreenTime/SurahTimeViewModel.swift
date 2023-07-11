//
//  SurahTimeViewModel.swift
//  QuranKZUIKIT2
//
//  Created by Али  on 02.07.2023.
//

import Foundation


class SurahTimeViewModel: NSObject {
    
    private var apiCaller: APICaller!
    
     var array: [String] = []
     var arrayInt: [Int] = []
    private var currentSura: NameSurah!

    var timer: Timer?

    
    private(set) var empData : Time! {
        didSet {
            self.bindViewModelToController()

        }
    }
    
    private(set) var currentSurah : NameSurah! {
        didSet {
            self.changeBack()
        }
    }
    
    
    var bindViewModelToController: (() -> ()) = {}
    
    var changeBack: (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiCaller = APICaller()
        callFuncToGetEmpData()

    }
    
    func callFuncToGetEmpData() {
        self.apiCaller.getTimePray { res in
            switch res {
            case .success(let success):
                
                DispatchQueue.main.async { [self] in
                    self.empData = success
                    self.currentSura = .besin
                    configureArray()
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    

    func secondsToString(_ seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        
        return String(format: "%02d:%02d", hours, minutes)
    }
    
    
    func timeStringToSeconds(_ timeString: String) -> Int? {
        var formattedTimeString = timeString
        
        // Handle the case when the time has the "*0:02" or "*2:02" format
        if formattedTimeString.hasPrefix("*") {
            let startIndex = formattedTimeString.index(formattedTimeString.startIndex, offsetBy: 1)
            let endIndex = formattedTimeString.index(formattedTimeString.startIndex, offsetBy: 2)
            let hourString = formattedTimeString[startIndex..<endIndex]
            formattedTimeString = "0\(hourString):\(formattedTimeString.suffix(2))"
        }
        
        let components = formattedTimeString.components(separatedBy: ":")
        if components.count == 2,
           let hours = Int(components[0]),
           let minutes = Int(components[1]) {
            return (hours * 3600) + (minutes * 60)
        }
        return nil
    }

    
    func configureArray() {
        sortTheArray()
        for i in arrayInt {
            array.append(secondsToString(i))
        }
        print(array)
    }
    
    func sortTheArray()  {
        self.arrayInt.append(timeStringToSeconds(empData.besin!)!)
        self.arrayInt.append(timeStringToSeconds(empData.kun!)!)
        self.arrayInt.append(timeStringToSeconds(empData.ishraq!)!)
        self.arrayInt.append(timeStringToSeconds(empData.ekindi!)!)
        self.arrayInt.append(timeStringToSeconds(empData.quptan!)!)
        self.arrayInt.append(timeStringToSeconds(empData.aqsham!)!)
        self.arrayInt.append(timeStringToSeconds(empData.bamdat!)!)
//        self.arrayInt.append(timeStringToSeconds("01:58")!)
        arrayInt.sort()
    }
    
    @objc func updateRemainingTime(timer: Timer) {
          guard let namazTimes = timer.userInfo as? [String] else {
              return
          }
          
          let remainingTime = getNextNamazTime(namazTimes: namazTimes)
//          label.text = "Remaining time to next Namaz: \(remainingTime)"
        
      }
    
    deinit {
          timer?.invalidate()
      }

    
    func getNextNamazTime(namazTimes: [String]) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let currentTime = Date()
        
        let currentNamazTimes = namazTimes.map { dateFormatter.date(from: $0)! }
        let calendar = Calendar.current
//        let originalDate = dateFormatter.date(from: originalTime)! // Original time as a date
        var currentNamazTime2: [Date] = []
        
        for i in currentNamazTimes {
            
            let originalDate = i
            
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
            let newDate = calendar.date(from: newDateComponents)!

            currentNamazTime2.append(newDate)

        }

     
        let nextNamazTime: Date
        
        if let nextTime = currentNamazTime2.first(where: { $0 > currentTime  }) {
            
            nextNamazTime = nextTime
        } else {

            let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: currentTime)!
            nextNamazTime = Calendar.current.date(bySettingHour: currentNamazTimes[0].hour, minute: currentNamazTimes[0].minute, second: 0, of: nextDay)!
        }
                                                                
        let remainingTime = nextNamazTime.timeIntervalSince(currentTime)
        let hours = Int(remainingTime) / 3600
        let minutes = (Int(remainingTime) % 3600) / 60
        let seconds = Int(remainingTime) % 60
        
        
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    func defineCurrentSura() {
        
    }
    
}


extension Date {
    var hour: Int {
        return Calendar.current.component(.hour, from: self)
    }

    var minute: Int {
        return Calendar.current.component(.minute, from: self)
    }
}
