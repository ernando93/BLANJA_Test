//
//  ForecastTableViewCell.swift
//  BLANJA_Test
//
//  Created by Ernando Kasaluhe on 20/04/19.
//  Copyright © 2019 Ernando Kasaluhe. All rights reserved.
//

import UIKit
import SDWebImage

class ForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var labelDay: UILabel!
    @IBOutlet weak var iconWeather: UIImageView!
    @IBOutlet weak var labelC: UILabel!
    
    func configureCell(withData data: Forecastday) {
        setupContent(withDate: data.date, withImageURL: data.day?.condition?.icon ?? "", andC: data.day?.avgTempC ?? 0)
    }
}

//MARK: - Setup Content
extension ForecastTableViewCell {
    func setupContent(withDate date: String, withImageURL imageURL: String, andC c: Double) {
        setupLabelDay(withDate: date, andLabel: labelDay)
        setupIconWeather(withImageURL: imageURL, andImageView: iconWeather)
        setupLabelC(withC: c, andLabel: labelC)
    }
    
    func setupLabelDay(withDate date: String, andLabel label: UILabel) {
        let day = Constant.getDayNameBy(stringDate: date)
        label.text = day
    }
    
    func setupIconWeather(withImageURL imageURL: String, andImageView imageView: UIImageView) {
        if imageURL != "" {
            let sdImageoption: SDWebImageOptions = .allowInvalidSSLCertificates
            imageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "iconProfile"), options: sdImageoption) {(image, error, cahceType, nil) in
                
                if image == nil {
                    imageView.image = UIImage(named: "iconProfile")
                }
            }
        } else {
            imageView.image = UIImage(named: "iconProfile")
        }
        imageView.image = UIImage(named: "rain")
    }
    
    func setupLabelC(withC c: Double, andLabel label: UILabel) {
        label.text = Constant.stringFormat(withDouble: c) + " C"
    }
}
