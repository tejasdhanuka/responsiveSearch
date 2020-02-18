//
//  ModelProvider.swift
//  ResponsiveSearch
//
//  Created by Tejas, Dhanuka on 2020/02/18.
//  Copyright © 2020 Tejas. All rights reserved.
//

import Foundation

// MARK: - ModelProvider protocol

public protocol ModelProvider {
    func loadInfo(with presenter: ViewModelPresenter)
    var fileName: String { get }
}

// MARK: - ModelType implementation

enum ModelType<T>: ModelProvider where T : Decodable {
    
    case cities
    
    var fileName: String {
        
        switch self {
        case .cities:
            return "cities"
        }
    }
    
    public func loadInfo(with presenter: ViewModelPresenter) {
        
        guard let decoded = fileName.decode(T.self)
            else {
                presenter.infoDidFailLoading(error: ModelError.failedLoading)
                return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            presenter.infoDidLoad(info: decoded)
        }
    }
}

// MARK: - Custom ModelError object

public enum ModelError: Error {
    case failedLoading
}

