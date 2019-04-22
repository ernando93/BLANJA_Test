//
//  SearchLocationViewController.swift
//  BLANJA_Test
//
//  Created by Ernando Kasaluhe on 22/04/19.
//  Copyright © 2019 Ernando Kasaluhe. All rights reserved.
//

import UIKit

protocol searchDelegate {
    func setupRequestWeather(withAddress address: String)
}

class SearchLocationViewController: UIViewController {

    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var buttonCancel: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var delegate: searchDelegate!
    var predictionAddress: [Prediction] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewContent()
    }
}

//MARK: - Setup View
extension SearchLocationViewController {
    func setupViewContent() {
        searchView.layer.cornerRadius = 6.0
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        buttonCancel.layer.cornerRadius = 6.0
        setupTableView(withTableView: tableView)
    }
    
    func setupTableView(withTableView tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "searchCell")
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
    }
}

//MARK: - Action
extension SearchLocationViewController {
    @IBAction func buttonCancelTapped(_ sender: UIButton) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - TextField Delegate
extension SearchLocationViewController: UITextFieldDelegate {
    @objc func textFieldDidChange(textField: UITextField) {
        if textField.text != "" {
            GooglePlacesAPI.searchPlaces(withSearchKey: textField.text!) { result in
                switch result {
                case .success(let responseGooglePlace):
                    self.predictionAddress = responseGooglePlace.predictions
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

//MARK: - TableView Delegate
extension SearchLocationViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return predictionAddress.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as? SearchTableViewCell {
            
            let data = predictionAddress[indexPath.row]
            cell.setupConfigureCell(withDescription: data.descriptionAPI)
            
            return cell
        } else {
            return SearchTableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = predictionAddress[indexPath.row]
        self.delegate.setupRequestWeather(withAddress: data.mainText)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.popViewController(animated: true)
    }
}
