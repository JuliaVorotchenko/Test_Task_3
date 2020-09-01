//
//  CitiesListViewController.swift
//  Test_Task_3
//
//  Created by Юлия Воротченко on 27.08.2020.
//  Copyright © 2020 Юлия Воротченко. All rights reserved.
//

import UIKit

enum CitiesListEvents {
    case cityDetails(Coordinates)
    case error(AppError)
}

final class CitiesListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var rootView: CitiesListView!
    
    // MARK: - Private Properties
    
    let eventHandler: (CitiesListEvents) -> ()
    private let jsonParser: JSONParser
    private var cityModels: [CityViewModel] = []
    
    // MARK: - Initialization
    
    init(eventHandler: @escaping (CitiesListEvents) -> (), jsonParser: JSONParser = JSONParserImpl()) {
        self.jsonParser = jsonParser
        self.eventHandler = eventHandler
        super.init(nibName: F.nibNamefor(Self.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print(Self.self)
    }
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTableView()
        self.getCities()
    }
    
    // MARK: - Private Methods
    
    private func setTableView() {
        self.rootView.citySearchBar.delegate = self
        self.rootView?.tableView.delegate = self
        self.rootView?.tableView.dataSource = self
        self.rootView.tableView.register(CityTableViewCell.self)
    }
    
    private func getCities() {
        let result = self.jsonParser.parseJSON(file: "cityList")
        switch result {
        case .success(let models):
            let path = models.count % 2 == 0 ? Path.evenUrl : .oddUrl
            self.cityModels = models.map { return CityViewModel(name: $0.name, url: path, coordinates: $0.coordinates)}
        case .failure(let error):
            self.eventHandler(.error(.unowned(error)))
        }
    }
    
    // MARK: - UITableViewDataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cityModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CityTableViewCell = tableView.dequeueReusableCell(CityTableViewCell.self, for: indexPath)
        cell.fill(with: self.cityModels[indexPath.row])
        return cell
    }
    
    // MARK: - UITableViewDelegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coordinates = self.cityModels[indexPath.row].coordinates
        self.eventHandler(.cityDetails(coordinates))
    }
    
    // MARK: - UISearchBarDelegate Mehtods
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchQuery = searchBar.text else { return }
        let filteredArr = self.cityModels.filter { $0.name.lowercased().contains(searchQuery.lowercased()) }
        
        if !searchText.isEmpty {
            self.cityModels = filteredArr
        } else {
            self.getCities()
        }
        self.rootView.tableView.reloadData()
    }
    
    //    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    //       guard let searchQuery = searchBar.text else { return }
    //        let filteredArr = self.cityModels.filter { $0.name.lowercased().contains(searchQuery.lowercased()) }
    //
    //        if !searchQuery.isEmpty {
    //            self.cityModels = filteredArr
    //            self.rootView.tableView.reloadData()
    //        }
    //
    //        searchBar.resignFirstResponder()
    //    }
    //
    //
    //
    //    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    //        guard let searchQuery = searchBar.text else { return }
    //        let filteredArr = self.cityModels.filter { $0.name.lowercased().contains(searchQuery.lowercased()) }
    //
    //        if !searchQuery.isEmpty {
    //            self.cityModels = filteredArr
    //        }
    //    }
    //
    //
    
}
