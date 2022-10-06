//
//  SearchService.swift
//  SiriusiOSAssignment
//
//  Created by Nay Oo Linn on 06/10/2022.
//

import RxSwift

// This class is for calling api.
// For this project, we will simply covert json file to data model
class SearchService {
    
    func loadData() -> Observable<[CityData]> {
        Observable<[CityData]>.create { observer in
            if let url = Bundle.main.url(forResource: "cities", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    let citiesData = try decoder.decode([CityData].self, from: data)
                    observer.onNext(citiesData)
                } catch {
                    observer.onError(ErrorEnvelope.error(error))
                }
            } else {
                observer.onError(ErrorEnvelope.message("No json file found."))
            }
            
            return Disposables.create()
        }
    }
}

