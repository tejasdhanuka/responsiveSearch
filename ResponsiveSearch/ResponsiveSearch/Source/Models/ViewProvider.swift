//
//  ViewProvider.swift
//  ResponsiveSearch
//
//  Created by Tejas, Dhanuka on 2020/02/18.
//  Copyright © 2020 Tejas. All rights reserved.
//

import Foundation

// MARK: - DecodedModelProvider protocol

public protocol DecodedModelProvider {
    
    associatedtype DecodedModelType
    var decodedInfo: DecodedModelType { get set }
}

// MARK: - ViewProvider protocol

public protocol ViewProvider: class {
    func configure(with decodedInfo: Decodable)
    func display(error: ModelError)
    func setActivityIndicator(hidden: Bool)
}
