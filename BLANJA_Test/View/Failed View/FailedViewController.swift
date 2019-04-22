//
//  FailedViewController.swift
//  BLANJA_Test
//
//  Created by Ernando Kasaluhe on 22/04/19.
//  Copyright © 2019 Ernando Kasaluhe. All rights reserved.
//

import UIKit

protocol FailedDelegate {
    func setupRequestWeather()
}

class FailedViewController: UIViewController {

    var delegate: FailedDelegate!
    @IBOutlet weak var buttonRetry: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContentLayout()
    }
}

//MARK: - Layout
extension FailedViewController {
    func setupContentLayout() {
        setupButtonRetry(withButton: buttonRetry)
    }
    
    func setupButtonRetry(withButton button: UIButton) {
        button.layer.cornerRadius = 1.0
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 0.0
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 4.0
        button.addTarget(self, action: #selector(buttonRetryTapped), for: .touchUpInside)
    }
}

//MARK: - Action
extension FailedViewController {
    @objc func buttonRetryTapped() {
        self.view.removeFromSuperview()
        self.delegate.setupRequestWeather()
    }
}
