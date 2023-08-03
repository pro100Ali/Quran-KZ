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
    

    var bindViewModelToController: (() -> ()) = {}
    
    
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
        arrayInt.sort()
    }

    
    deinit {
          timer?.invalidate()
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
