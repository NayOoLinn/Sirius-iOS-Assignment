//
//  SearchVM.swift
//  SiriusiOSAssignment
//
//  Created by Nay Oo Linn on 06/10/2022.
//

import RxCocoa
import RxSwift

// MARK: - Prepare
class SearchVM {
    
    struct Input {
        let viewDidAppear: Observable<Void>
        let search: Observable<String>
    }
    
    struct Output {
        let error: Driver<ErrorEnvelope>
        let cities: Driver<[CityData]>
    }
    
    struct DataModel {
        var data: [CityData] = []
        var sortedData: [String: [CityData]] = [:]
        var searchedData: [String: [CityData]] = [:]
    }
    
    var dataModel = DataModel()
    
    func transform(_ input: Input) -> Output {
        let error = ErrorTracker()
        
        let model = SearchService()
        
        let data = input.viewDidAppear
            .flatMap {
                model.loadData()
                    .trackError(error)
            }
            .map(sortDataByName)
            .map(sortDataForSearch)
            .share()
        
        let result = input.search
            .map(search)
            .share()

        let cities = Observable.merge(data, result)
        
        return Output(
            error: error.asDriver(),
            cities: cities.asDriverOnErrorNever()
        )
    }
    
}

// MARK: - Business Logic
extension SearchVM {
    
    func sortDataByName(_ cities: [CityData]) -> [CityData] {
        dataModel.data = cities.sorted {
            $0.name ?? "" < $1.name ?? ""
        }
        return dataModel.data
    }
    
    // Sort data for better filter performance
    func sortDataForSearch(_ cities: [CityData]) -> [CityData] {
        // Group cities by first character
        dataModel.sortedData = Dictionary(grouping: cities) {
            String($0.name?.first ?? Character("")).lowercased()
        }
        return cities
    }
    
    // Search by keyword
    func search(_ keyword: String) -> [CityData] {
        // Trim keyword
        let key = keyword.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        if key.isEmpty { return dataModel.data }
        
        // Search from already searched data
        if let searchedCities = dataModel.searchedData[key] {
            return searchedCities
        }

        // Guard
        guard let firstChar = key.first else { return [] }

        // Search from sorted data
        let firstLetter = String(firstChar)
        let cities = dataModel.sortedData[firstLetter]?.filter({
            $0.name?.lowercased().hasPrefix(key) ?? false
        }) ?? []

        // Saved searched data
        dataModel.searchedData[key] = cities
        return cities
    }
}
