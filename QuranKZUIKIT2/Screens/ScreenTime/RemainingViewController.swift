import UIKit

class RemainingViewController: UIViewController {
    
    lazy private var label: UILabel = {
       let label = UILabel()
        label.text = "adas"
        return label
    }()

    var timer: Timer?

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        label.frame = view.bounds
        let namazTimes = ["00:02", "02:04", "05:02", "13:29", "19:00", "21:31"]
        let remainingTime = getNextNamazTime(namazTimes: namazTimes)
        print("Remaining time to next Namaz: \(remainingTime)")
        view.backgroundColor = .white
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateRemainingTime), userInfo: namazTimes, repeats: true)

    }
    
    @objc func updateRemainingTime(timer: Timer) {
          guard let namazTimes = timer.userInfo as? [String] else {
              return
          }
          
          let remainingTime = getNextNamazTime(namazTimes: namazTimes)
          label.text = "Remaining time to next Namaz: \(remainingTime)"
        
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

            // Extract year, month, and day components from the current date
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
//        print(currentNamazTimes[1] > currentTime)
//
//        print("02:04 \(currentNamazTime2[0])")
//        print("05:02 \(currentNamazTime2[1])")
//        print("13:29 \(currentNamazTime2[2])")
//        print("19:00 \(currentNamazTime2[3])")
//        print("21:31 \(currentNamazTime2[4])")
//        print("00:02 \(currentNamazTime2[5])")
//        print("current time \(currentTime)")
     
        let nextNamazTime: Date
        
        if let nextTime = currentNamazTime2.first(where: { $0 > currentTime  }) {
//               print(nextTime)
            print(currentTime)
            print(nextTime)
               nextNamazTime = nextTime
           } else {
            // The next namaz time is the first namaz of the next day
            let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: currentTime)!
            nextNamazTime = Calendar.current.date(bySettingHour: currentNamazTimes[0].hour, minute: currentNamazTimes[0].minute, second: 0, of: nextDay)!
        }
                                                                
        let remainingTime = nextNamazTime.timeIntervalSince(currentTime)
        let hours = Int(remainingTime) / 3600
        let minutes = (Int(remainingTime) % 3600) / 60
        let seconds = Int(remainingTime) % 60
        
        
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
}



