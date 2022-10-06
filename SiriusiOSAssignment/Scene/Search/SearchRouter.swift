//
//  SearchRouter.swift
//  SiriusiOSAssignment
//
//  Created by Nay Oo Linn on 06/10/2022.
//

import Foundation

class SearchRouter: BaseRouter {
    func routeToDetail(data: CityData) {
        let vc = CityDetailVC.instantiate()
        vc.data = data
        vc.modalPresentationStyle = .fullScreen
        viewController?.present(vc, animated: true)
    }
}
