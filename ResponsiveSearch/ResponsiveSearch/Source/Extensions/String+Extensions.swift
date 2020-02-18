//
//  String+Extensions.swift
//  ResponsiveSearch
//
//  Created by Tejas, Dhanuka on 2020/02/18.
//  Copyright © 2020 Tejas. All rights reserved.
//

import Foundation

extension String {
    
    func decode<T>(_ decodable: T.Type) -> T? where T : Decodable {
        
        guard
            let path = Bundle.main.path(forResource: self, ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
            let decoded = try? JSONDecoder().decode(decodable, from: data)
            else {
                return nil
        }
        return decoded
    }
}
