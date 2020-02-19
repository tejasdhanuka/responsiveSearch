//
//  MasterViewController.swift
//  ResponsiveSearch
//
//  Created by Tejas, Dhanuka on 2020/02/18.
//  Copyright © 2020 Tejas. All rights reserved.
//

import UIKit

class MasterViewController: BaseTableViewController, PagingTable {
    
    static let citiesJSONFile = "cities"
    static let detailSegueIdentifier = "showDetail"
    static let pageLimit = 50
    
    var decodedInfo = [CityInfo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.accessibilityIdentifier = "citiesListView"
        let modelPresenter = Presenter(view: self, model: ModelType<Array<CityInfo>>.cities)
        presenter = modelPresenter
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == MasterViewController.detailSegueIdentifier {
            guard let detailViewController = (segue.destination as? UINavigationController)?.topViewController as? DetailViewController
                else { return }
            
            if let indexPath = tableView.indexPathForSelectedRow {
                detailViewController.detailItem = items[indexPath.row]
                detailViewController.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                detailViewController.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    // MARK: - Table View delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: MasterViewController.detailSegueIdentifier, sender: nil)
        searchController.isActive = false
    }
    
    // MARK: - Protocol CellStyleCustomizable implementation
    
    var cellStyle: UITableViewCell.CellStyle {
        return .subtitle
    }
    
    override func configure(with decodedInfo: Decodable) {
        self.decodedInfo = (decodedInfo as? [CityInfo])?.sortedByCityFirst() ?? []
        
        findItems(with: nil) { [weak self] (newItems) in
            self?.items = newItems ?? []
            self?.tableView.reloadData()
            
            let label = UILabel(frame: .zero)
            label.textColor = UIColor.black
            label.accessibilityIdentifier = "citiesListTitle"
            label.text = "Responsive Search"
            label.font = UIFont.boldSystemFont(ofSize: 18)
            label.sizeToFit()
            self?.navigationItem.titleView = label
        }
    }
    
    // MARK: - Searchable
    
    func findItems(with query: String?, completion: SearchCompletion?) {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive).async { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.setActivityIndicator(hidden: false)
            }
            let startIndex = self.items.count
            var endIndex = startIndex + MasterViewController.pageLimit
            guard let query = query, !query.isEmpty else {
                if endIndex > self.decodedInfo.count {
                    endIndex = self.decodedInfo.count
                }
                if startIndex < endIndex {
                    DispatchQueue.main.async {
                        self.setActivityIndicator(hidden: true)
                        completion?(Array(self.decodedInfo[startIndex..<endIndex]))
                    }
                } else {
                    DispatchQueue.main.async {
                        self.setActivityIndicator(hidden: true)
                        completion?(nil)
                    }
                }
                return
            }
            
            let filteredItems = self.decodedInfo.filtered(with: query)
            
            if endIndex > filteredItems.count {
                endIndex = filteredItems.count
            }
            if startIndex < endIndex {
                DispatchQueue.main.async {
                    self.setActivityIndicator(hidden: true)
                    completion?(Array(filteredItems[startIndex..<endIndex]))
                }
            } else {
                DispatchQueue.main.async {
                    self.setActivityIndicator(hidden: true)
                    self.items.removeAll()
                    completion?(nil)
                }
            }
        }
    }
}

