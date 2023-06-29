//
//  Color.swift
//  QuranKZUIKIT2
//
//  Created by Али  on 20.06.2023.
//

import Foundation
import UIKit

class Color {
    static var shared = Color()
    
    var fajr = UIColor(red: 0.93, green: 0.52, blue: 0.25, alpha: 1.00)
    var sunrise = UIColor(red: 0.94, green: 0.60, blue: 0.27, alpha: 1.00)
    var dhuhr = UIColor(red: 0.96, green: 0.76, blue: 0.38, alpha: 1.00)
    var asr = UIColor(red: 0.28, green: 0.59, blue: 0.73, alpha: 1.00)
    var maghrib = UIColor(red: 0.23, green: 0.46, blue: 0.72, alpha: 1.00)
    var isha = UIColor(red: 0.19, green: 0.33, blue: 0.58, alpha: 1.00)
    
    
    var greenRect = UIColor(red: 0.33, green: 0.73, blue: 0.62, alpha: 1.00)
    var redRect = UIColor(red: 0.93, green: 0.45, blue: 0.37, alpha: 1.00)
    var purpleRect = UIColor(red: 0.60, green: 0.40, blue: 0.71, alpha: 1.00)
    var yellowRect = UIColor(red: 0.96, green: 0.80, blue: 0.33, alpha: 1.00)
    var blueRect = UIColor(red: 0.30, green: 0.67, blue: 0.82, alpha: 1.00)
}

struct Font {
    static var shared = Font()
    
    var basic = UIFont(name: "Noteworthy", size: 50)
}
