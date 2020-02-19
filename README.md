# responsiveSearch
An iOS Project/POC to demonstrate responsive search functionality. Data to be loaded from JSON file.

# Explaination
- This project was create using Master Details Template available in Xcode.
- Master View Controller will be used to show the list of cities with a search bar on top to filter the cities
- Selecting a City will show show its details on the map
- Detail View Controller will be used to show the city on the default map provided by iOS using mapkit
- Json file consisting of list of cities and the about info json are added under "Resources" folder.
- Pagination is used to provide smooth scrolling and better user experience 
- UI Tests are done and added to ResponsiveSearchUITests.swift
- Unit Tests are done to check the SearchFilter logic, Model Provider, View Provider and ViewModel Presenter
- Performance Tests are added to ResponsiveSearchTests.swift

# Protocol Associated Types
- PATs is used inside the protocol 'DecodedModelProvider' to define generic type for decoded data corresponding to each model
- Generics and protocol associated type helps to reuse Model View Presenter across different view controllers that depend on loading data from a json file

# Inheritance
- Used Inheritance to reduce code and improve readability
- BaseTableViewController can be used to create any TableViewController by providing the items array
- Search Capability is added to any UITableViewController that conforms to Searchable protocol provided that it's inherited from BaseTableViewController
