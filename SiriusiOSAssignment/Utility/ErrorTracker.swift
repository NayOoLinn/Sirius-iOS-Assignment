//
//  ErrorTracker.swift
//  SiriusiOSAssignment
//
//  Created by Nay Oo Linn on 06/10/2022.
//

import RxCocoa
import RxSwift

final class ErrorTracker: SharedSequenceConvertibleType {
    
    typealias SharingStrategy = DriverSharingStrategy
    private let _subject = PublishSubject<ErrorEnvelope>()

    init() { }
    
    func trackError<O: ObservableConvertibleType>(from source: O) -> Observable<O.Element> {
        return source.asObservable()
            .catch { [_subject] error in
                if let error = error as? ErrorEnvelope {
                    _subject.onNext(error)
                } else {
                    _subject.onNext(ErrorEnvelope.message(error.localizedDescription))
                }
                return Observable.empty()
            }
    }

    func asSharedSequence() -> SharedSequence<SharingStrategy, ErrorEnvelope> {
        return _subject.asObservable().asDriverOnErrorJustComplete()
    }

    func asObservable() -> Observable<ErrorEnvelope> {
        return _subject.asObservable()
    }
    
    deinit {
        _subject.onCompleted()
    }
}

extension ObservableConvertibleType {
    func trackError(_ errorTracker: ErrorTracker) -> Observable<Element> {
        return errorTracker.trackError(from: self)
    }
}
