//
//  RxSwift.swift
//  SiriusiOSAssignment
//
//  Created by Nay Oo Linn on 06/10/2022.
//

import RxCocoa
import RxSwift

public extension ObservableType {
    
    func catchErrorJustComplete() -> Observable<Element> {
        self.catch { _ in
            return Observable.empty()
        }
    }
    
    func asDriverOnErrorJustComplete() -> Driver<Element> {
        asDriver { error in
            return Driver.empty()
        }
    }
    
    func asDriverOnErrorNever() -> Driver<Element> {
        asDriver { error in
            return .never()
        }
    }
    
    func mapToVoid() -> Observable<Void> {
        map { _ in }
    }
}
