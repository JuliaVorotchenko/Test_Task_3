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
    private var cities: [CityViewModel] = []
    private var filteredCities: [CityViewModel] = []
    
    private var isSearchBarEmpty: Bool  {
        return rootView.citySearchBar.text?.isEmpty ?? true
    }
    
    private var isFiltering: Bool {
        return self.rootView.citySearchBar.isFirstResponder
            && !isSearchBarEmpty
    }
    
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
        self.setSubViews()
        self.getCities()
    }
    
    // MARK: - Private Methods
    
    private func setSubViews() {
        self.rootView.citySearchBar.delegate = self
        self.rootView?.tableView.delegate = self
        self.rootView?.tableView.dataSource = self
        self.rootView.tableView.register(CityTableViewCell.self)
        self.rootView.tableView.keyboardDismissMode = .onDrag
    }
    
    private func getCities() {
        let result = self.jsonParser.parseJSON(file: "cityList")
        switch result {
        case .success(let models):
            let result: [CityViewModel] = models
                .enumerated()
                .compactMap { tuple in
                    let path = tuple.offset.isMultiple(of: 2) ? Path.evenUrl : Path.oddUrl
                    return CityViewModel(name: tuple.element.name, url: path, coordinates: tuple.element.coordinates)
            }
            self.cities = result
        case .failure:
            self.eventHandler(.error(.jsonError))
        }
    }
    
    private func filterCitiesBySearchText(_ searchText: String) {
        self.filteredCities = self.cities.filter { $0.name.lowercased().contains(searchText.lowercased())}
        self.rootView.tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCities.count
        }
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CityTableViewCell = tableView.dequeueReusableCell(CityTableViewCell.self, for: indexPath)
        let city: CityViewModel
        if isFiltering {
            city = filteredCities[indexPath.row]
        } else {
            city = cities[indexPath.row]
        }
        cell.fill(with: city)
        return cell
    }
    
    // MARK: - UITableViewDelegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coordinates: Coordinates
        if isFiltering {
            coordinates = filteredCities[indexPath.row].coordinates
        } else {
            coordinates = cities[indexPath.row].coordinates
        }
        self.eventHandler(.cityDetails(coordinates))
    }
    
    // MARK: - UISearchBarDelegate Mehtods
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filterCitiesBySearchText(searchText)
        self.rootView.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        self.filterCitiesBySearchText(searchText)
        self.rootView.tableView.reloadData()
        searchBar.resignFirstResponder()
    }
}
