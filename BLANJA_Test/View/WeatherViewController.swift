//
//  WeatherViewController.swift
//  BLANJA_Test
//
//  Created by Ernando Kasaluhe on 20/04/19.
//  Copyright © 2019 Ernando Kasaluhe. All rights reserved.
//

import UIKit
import MapKit

class WeatherViewController: UIViewController {

    var weather: Weather?
    var location: Location?
    var current: CurrentWeather?
    var forecast: ForecastWeather?
    var forecastDay = [Forecastday]()
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    @IBOutlet weak var viewHide: UIView!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var labelCondition: UILabel!
    @IBOutlet weak var labelC: UILabel!
    @IBOutlet weak var labelDateTime: UILabel!
    @IBOutlet weak var labelHumidity: UILabel!
    @IBOutlet weak var labelWind: UILabel!
    @IBOutlet weak var labelPressure: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let imageLoading: UIImageView = {
        let setupImage = UIImageView()
        setupImage.image = UIImage(named: "ic_loading.png")
        setupImage.translatesAutoresizingMaskIntoConstraints = false
        return setupImage
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayoutView()
        setupLocationManager()
    }
    
    func setupLocationManager() {
        locationManager.requestAlwaysAuthorization()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
        
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                print("No access")
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
            @unknown default:
                print("Default")
            }
        } else {
            print("Location services are not enabled")
        }
        
        var stringLat: Double = -6.175392
        var stringLon: Double = 106.827153
        
        stringLat = locationManager.location == nil ? stringLat : (locationManager.location?.coordinate.latitude)!
        stringLon = locationManager.location == nil ? stringLon : (locationManager.location?.coordinate.longitude)!
        
        requestWeather(withQ: "\(stringLat),\(stringLon)", andDays: 7)
    }

}

//MARK: - Setup Layout
extension WeatherViewController {
    func setupLayoutView() {
        isHideContent(withIsHide: true, andLoadingHide: false)
        self.view.addSubview(imageLoading)
        addConstraintToImageLoading()
        setupImageLoading(imageView: imageLoading, aCircleTime: 1.0)
        setupTableView(withTableView: tableView)
    }
    
    func isHideContent(withIsHide isHide: Bool, andLoadingHide loadingHide: Bool) {
        imageLoading.isHidden = loadingHide
        UIView.animate(withDuration: 1.0, animations: {
            self.viewHide.isHidden = loadingHide
            self.tableView.isHidden = isHide
            self.setupTransitionTableView()
        })
    }
    
    func setupImageLoading(imageView: UIImageView, aCircleTime: Double) {
        UIView.animate(withDuration: aCircleTime/2, delay: 0.0, options: .curveLinear, animations: {
            imageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        }, completion: { finished in
            UIView.animate(withDuration: aCircleTime/2, delay: 0.0, options: .curveLinear, animations: {
                imageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi*2))
            }, completion: { finished in
                self.setupImageLoading(imageView: imageView, aCircleTime: aCircleTime)
            })
        })
    }
    
    func addConstraintToImageLoading() {
        imageLoading.widthAnchor.constraint(equalToConstant: 96).isActive = true
        imageLoading.heightAnchor.constraint(equalToConstant: 96).isActive = true
        imageLoading.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageLoading.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func setupTableView(withTableView tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        
        let shadowSize : CGFloat = 5.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: self.view.frame.width,
                                                   height: 2.0))
        tableView.layer.masksToBounds = false
        tableView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        tableView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        tableView.layer.shadowOpacity = 0.5
        tableView.layer.shadowPath = shadowPath.cgPath
        
        tableView.register(UINib(nibName: "ForecastTableViewCell", bundle: nil), forCellReuseIdentifier: "forecastCell")
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
    }
    
    func setupTransitionTableView() {
        let transition = CATransition()
        transition.type = CATransitionType.push
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.fillMode = CAMediaTimingFillMode.forwards
        transition.duration = 1.0
        transition.subtype = CATransitionSubtype.fromTop
        self.tableView.layer.add(transition, forKey: "UITableViewReloadDataAnimationKey")
        self.tableView.reloadData()
    }
}

//MARK: Request
extension WeatherViewController {
    func requestWeather(withQ q: String, andDays days: Int) {
        Weather.getWeather(withQ: q.lowercased(), withDays: days) { result in
            
            switch result {
                
            case .success(let response):
                self.location = response.location
                self.current = response.current
                self.forecast = response.forecast
                self.forecastDay = (self.forecast?.forecastday)!
                self.setupContentView(withLocation: self.location?.name ?? "", withCondition: self.current?.condition?.text ?? "", withC: self.current?.tempC ?? 0, withDate: self.location?.localTime ?? "", withHumidity: self.current?.humidity ?? 0, withWind: self.current?.windMph ?? 0, withPressure: self.current?.pressureMb ?? 0)
                self.isHideContent(withIsHide: false, andLoadingHide: true)
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
                self.setupFailedView()
            }
        }
    }
}

//MARK: - Setup Content
extension WeatherViewController {
    func setupContentView(withLocation location: String, withCondition condition: String, withC c: Double, withDate date: String, withHumidity humidity: Int, withWind wind: Double, withPressure pressure: Double) {
        setupLabelLocation(withLabel: labelLocation, andLocation: location)
        setupLabelCondition(withLabel: labelCondition, andCondition: condition)
        setupLabelC(withLabel: labelC, andC: c)
        setupLabelDateTime(withLabel: labelDateTime, andDateTime: date)
        setupLabelHumidity(withLabel: labelHumidity, andHumidity: humidity)
        setupLabelWind(withLabel: labelWind, andWind: wind)
        setupLabelPressure(withLabel: labelPressure, andPressure: pressure)
    }
    
    func setupLabelLocation(withLabel label: UILabel, andLocation location: String) {
        label.text = location
    }
    
    func setupLabelCondition(withLabel label: UILabel, andCondition condition: String) {
        label.text = condition
    }
    
    func setupLabelC(withLabel label: UILabel, andC c: Double) {
        label.text = Constant.stringFormat(withDouble: c) + "°"
    }
    
    func setupLabelDateTime(withLabel label: UILabel, andDateTime dateTime: String) {
        let fullDateTime = dateTime.components(separatedBy: " ")
        
        let date = Constant.getDayNameBy(stringDate: fullDateTime[0])
        let time = fullDateTime[1]
        label.text = "\(date), \(time)"
    }
    
    func setupLabelHumidity(withLabel label: UILabel, andHumidity humidity: Int) {
        label.text = String(humidity) + " %"
    }
    
    func setupLabelWind(withLabel label: UILabel, andWind wind: Double) {
        label.text = Constant.stringFormat(withDouble: wind) + " MPH"
    }
    
    func setupLabelPressure(withLabel label: UILabel, andPressure pressure: Double) {
        label.text = Constant.stringFormat(withDouble: pressure) + " mb"
    }
}

//MARK: - TableView Delegate
extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastDay.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "forecastCell", for: indexPath) as? ForecastTableViewCell {
            
            let data = forecastDay[indexPath.row]
            cell.configureCell(withData: data)
            
            return cell
        } else {
            return ForecastTableViewCell()
        }
    }
}

//MARK: - Action
extension WeatherViewController {
    @IBAction func buttonSearchTapped(_ sender: UIButton) {
        self.navigationController?.navigationBar.isHidden = true
        let vc = SearchLocationViewController(nibName: "SearchLocationViewController", bundle: nil)
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupFailedView() {
        let vc = FailedViewController(nibName: "FailedViewController", bundle: nil)
        vc.delegate = self
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
}

// MARK: - Location Manager
extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
}

//MARK: - Search Delegate
extension WeatherViewController: searchDelegate {
    func setupRequestWeather(withAddress address: String) {
        isHideContent(withIsHide: true, andLoadingHide: false)
        self.requestWeather(withQ: address, andDays: 7)
    }
}

//MARK: - Failed Delegate
extension WeatherViewController: FailedDelegate {
    func setupRequestWeather() {
        var stringLat: Double = -6.175392
        var stringLon: Double = 106.827153
        
        stringLat = locationManager.location == nil ? stringLat : (locationManager.location?.coordinate.latitude)!
        stringLon = locationManager.location == nil ? stringLon : (locationManager.location?.coordinate.longitude)!
        
        requestWeather(withQ: "\(stringLat),\(stringLon)", andDays: 7)
    }
}
