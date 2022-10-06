//
//  UIViewController.swift
//  SiriusiOSAssignment
//
//  Created by Nay Oo Linn on 06/10/2022.
//

import UIKit
import RxCocoa
import RxSwift

// MARK: - View LifeCycle
public extension Reactive where Base: UIViewController {
    
    var viewDidLoad: ControlEvent<Bool> {
        let source = self.methodInvoked(#selector(Base.viewDidLoad)).map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
    
    var viewWillAppear: ControlEvent<Bool> {
        let source = self.methodInvoked(#selector(Base.viewWillAppear)).map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
    
    var viewDidAppear: ControlEvent<Bool> {
        let source = self.methodInvoked(#selector(Base.viewDidAppear)).map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
    
    var viewWillDisappear: ControlEvent<Bool> {
        let source = self.methodInvoked(#selector(Base.viewWillDisappear)).map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
    
    var viewDidDisappear: ControlEvent<Bool> {
        let source = self.methodInvoked(#selector(Base.viewDidDisappear)).map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
}

// MARK: - Alert
extension UIViewController {
    func showAlert(
        title: String? = "",
        message: String?,
        actionTitle: String = "OK",
        actionCallback: (() -> Void)? = nil
    ) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alertController.addAction(
            UIAlertAction(
                title: actionTitle,
                style: .default,
                handler: { (_) in
                    alertController.dismiss(animated: true, completion: nil)
                    actionCallback?()
                }
            )
        )
        present(
            alertController,
            animated: true,
            completion: nil
        )
    }
}

