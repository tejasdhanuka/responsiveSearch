//
//  ViewModelPresenter.swift
//  ResponsiveSearch
//
//  Created by Tejas, Dhanuka on 2020/02/18.
//  Copyright © 2020 Tejas. All rights reserved.
//

import Foundation

// MARK: - ViewModelPresenter protocl

public protocol ViewModelPresenter {
    func loadInfo()
    func infoDidLoad(info: Decodable)
    func infoDidFailLoading(error: ModelError)
}

// MARK: - Presenter implementation

public final class Presenter: ViewModelPresenter {
    private weak var view: ViewProvider?
    private let model: ModelProvider
    
    public init(view: ViewProvider?, model: ModelProvider) {
        self.view = view
        self.model = model
    }
    
    public func loadInfo() {
        self.view?.setActivityIndicator(hidden: false)
        self.model.loadInfo(with: self)
    }
    
    public func infoDidLoad(info: Decodable) {
        self.view?.configure(with: info)
        self.view?.setActivityIndicator(hidden: true)
    }
    
    public func infoDidFailLoading(error: ModelError) {
        self.view?.setActivityIndicator(hidden: true)
        self.view?.display(error: error)
    }
}
