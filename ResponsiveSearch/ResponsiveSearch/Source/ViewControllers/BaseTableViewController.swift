//
//  BaseTableViewController.swift
//  ResponsiveSearch
//
//  Created by Tejas, Dhanuka on 2020/02/18.
//  Copyright © 2020 Tejas. All rights reserved.
//

import UIKit

protocol TitleDetailProvider {
    var title: String { get }
    var detail: String  { get }
}

protocol CellStyleCustomizable {
    var cellStyle: UITableViewCell.CellStyle { get }
}

protocol Searchable {
    typealias SearchCompletion = (_ newItems: [TitleDetailProvider]?) -> Void
    func findItems(with query: String?, completion: SearchCompletion?)
}

protocol PagingTable: Searchable { }

class BaseTableViewController: UITableViewController, ViewProvider, UISearchResultsUpdating {

    static let cellIdentifier = "ItemCell"
    static let searchPlaceholder = "Search"
    
    let activityIndicatorView = UIActivityIndicatorView(style: .white)
    
    var searchController: UISearchController = UISearchController(searchResultsController: nil)
    var isLoading: Bool = false
    var isDecelerating: Bool = false
    var items = [TitleDetailProvider]()
    var presenter: ViewModelPresenter? {
        didSet {
            presenter?.loadInfo()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = self.activityIndicatorView
        self.activityIndicatorView.hidesWhenStopped = true
        tableView.backgroundColor = UIColor(red: 40, green: 47, blue: 60, alpha: 1)
        self.activityIndicatorView.accessibilityIdentifier = "activityIndicator"
    }

    // MARK: - View Lifecycle methods
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        
        if self is Searchable {
            searchController = UISearchController(searchResultsController: nil)
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchBar.sizeToFit()
            searchController.searchBar.searchBarStyle = .minimal
            searchController.searchBar.tintColor = UIColor.white
            searchController.searchBar.placeholder = BaseTableViewController.searchPlaceholder
            searchController.searchResultsUpdater = self
            searchController.searchBar.accessibilityIdentifier = "searchBar"
            
            definesPresentationContext = false
            if #available(iOS 11.0, *) {
                navigationItem.largeTitleDisplayMode = .always
                navigationItem.searchController = searchController
                navigationItem.hidesSearchBarWhenScrolling = false
            } else {
                // Fallback on earlier versions
                tableView.tableHeaderView = searchController.searchBar
            }
            tableView.keyboardDismissMode = .onDrag
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if self is Searchable {
            if #available(iOS 11.0, *) {
                navigationItem.hidesSearchBarWhenScrolling = true
            }
        }
    }
    
    // MARK: - ModelViewProvider protocol methods
    
    func configure(with decodedInfo: Decodable) {
        
    }
    
    func display(error: ModelError) {
        showAlert(with: error)
    }
    
    func setActivityIndicator(hidden: Bool) {
        if hidden {
            self.activityIndicatorView.stopAnimating()
        } else {
            self.activityIndicatorView.startAnimating()
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        let cellStyle = (self as? CellStyleCustomizable)?.cellStyle ?? .subtitle
        if let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: BaseTableViewController.cellIdentifier) {
            cell = dequeuedCell
        } else {
            cell = UITableViewCell(style: cellStyle, reuseIdentifier: BaseTableViewController.cellIdentifier)
            cell.selectionStyle = .none
        }
        
        cell.accessibilityIdentifier = "Cell-\(indexPath.row)"
        cell.textLabel?.accessibilityIdentifier = "CellTitleLabel-\(indexPath.row)"
        cell.detailTextLabel?.accessibilityIdentifier = "CellDetailLabel-\(indexPath.row)"
        
        let item = items[indexPath.row]
        
        cell.textLabel?.textColor = UIColor.white
        cell.detailTextLabel?.textColor = UIColor.white

        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.detail
        cell.backgroundColor = UIColor(red: 40.0/255.0, green: 47.0/255.0, blue: 60.0/255.0, alpha: 1.0)

        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == tableView.dataSource!.tableView(tableView, numberOfRowsInSection: indexPath.section) - 1,  !isLoading {
            isLoading = true
            let searchText = self.searchController.searchBar.text
            guard items.count > 0, isDecelerating else {
                return
            }
            (self as? PagingTable)?.findItems(with: searchText) { [weak self] (newItems) in
                self?.updateTable(with: newItems)
            }
        }
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        isDecelerating = decelerate
    }
    
    // MARK: - UISearchResultsUpdating Delegate
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            items.removeAll()
            isLoading = true
            isDecelerating = false
            (self as? Searchable)?.findItems(with: searchText) { [weak self] (newItems) in
                self?.items.removeAll()
                self?.updateTable(with: newItems)
            }
        }
    }
    
    // MARK: - Handle the scroll view delegate for handing pagination

    func updateTable(with newItems: [TitleDetailProvider]?) {
        guard let newItems = newItems, newItems.count > 0 else {
            isLoading = false
            tableView.reloadData()
            return
        }
        items.append(contentsOf: newItems)
        DispatchQueue.main.async { [unowned self] in
            self.tableView.reloadData()
        }
        isLoading = false
    }
}
