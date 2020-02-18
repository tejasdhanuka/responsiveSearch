//
//  ArrayCityInfo+Extensions.swift
//  ResponsiveSearch
//
//  Created by Tejas, Dhanuka on 2020/02/18.
//  Copyright © 2020 Tejas. All rights reserved.
//

import UIKit

public extension Array where Element: CityInfo {
    
    func filtered(with query: String) -> [CityInfo] {
        if query.isEmpty {
            return self
        }
        return filter {
            $0.name.lowercased().starts(with: query.lowercased()) || $0.country.lowercased().starts(with: query.lowercased())
            }.sortedByCityFirst()
    }
    
    func sortedByCityFirst() -> [CityInfo] {
        return sorted {
            let city0 = $0.name.lowercased()
            let city1 = $1.name.lowercased()
            
            if city0 != city1 {
                return city0 < city1
            } else {
                return $0.country.lowercased() < $1.country.lowercased()
            }
        }
    }
}
