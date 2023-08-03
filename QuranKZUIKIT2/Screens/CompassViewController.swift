import UIKit
import CoreLocation

class CompassViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    let compassView = UIImageView(image: UIImage(named: "compass"))
    let angleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // UI Setup
        view.addSubview(compassView)
        compassView.center = view.center
        angleLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 20)
        angleLabel.center = CGPoint(x: view.center.x, y: view.center.y + compassView.bounds.height / 2 + 20)
        angleLabel.textColor = .black
        angleLabel.backgroundColor = .red
        view.addSubview(angleLabel)
//        if (self.locationManager != nil){
//            print("yes")
//        }
        // Location setup
        locationManager.requestWhenInUseAuthorization()

        self.locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
   
        locationManager.stopUpdatingHeading()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        let qiblaDirection = calculateQiblaDirection(from: manager.location?.coordinate)
        
        let angle = newHeading.trueHeading - qiblaDirection
        let angleInRadians = (angle * .pi) / 180
        compassView.transform = CGAffineTransform(rotationAngle: CGFloat(angleInRadians))
        angleLabel.text = "Qibla angle: \(angle)"
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations:  [AnyObject]!) {
        print("hgfds")

    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("hgfds")
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        print("jhgfders")
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            locationManager.startUpdatingHeading()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied: break
            // Handle the case where the user denied location access
            // Show an alert or guide the user to enable location services
        @unknown default:
            break
        }
    }

    func calculateQiblaDirection(from coordinate: CLLocationCoordinate2D?) -> Double {
        guard let coordinate = coordinate else { return 0 }
        
        let latitude = degreesToRadians(coordinate.latitude)
        let longitude = degreesToRadians(coordinate.longitude)
        
        // Coordinates of Kaaba
        let kaabaLatitude = degreesToRadians(50)
        let kaabaLongitude = degreesToRadians(90)
        
        let deltaLongitude = kaabaLongitude - longitude
        
        let numerator = sin(deltaLongitude)
        let denominator = cos(latitude) * tan(kaabaLatitude) - sin(latitude) * cos(deltaLongitude)
        
        var qiblaDirection = radiansToDegrees(atan2(numerator, denominator))
        if qiblaDirection < 0 {
            qiblaDirection += 360
        }
        
        return qiblaDirection
    }
    
    func degreesToRadians(_ degrees: Double) -> Double {
        return degrees * .pi / 180
    }
    
    func radiansToDegrees(_ radians: Double) -> Double {
        return radians * 180 / .pi
    }
}
