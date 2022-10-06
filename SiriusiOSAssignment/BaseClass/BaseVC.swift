//
//  BaseVC.swift
//  SiriusiOSAssignment
//
//  Created by Nay Oo Linn on 06/10/2022.
//

import UIKit
import RxCocoa
import RxSwift

class BaseVC: UIViewController {
    
}

extension Reactive where Base: BaseVC {
    var error: Binder<ErrorEnvelope> {
        Binder(base) {
            $0.showAlert(message: $1.description)
        }
    }
}
