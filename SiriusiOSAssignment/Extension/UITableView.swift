//
//  UITableView.swift
//  SiriusiOSAssignment
//
//  Created by Nay Oo Linn on 06/10/2022.
//

import UIKit

// MARK: - Register
extension UITableView {
    
    func register<cell: UITableViewCell>(_ cell: cell.Type) {
        register(
            cell,
            forCellReuseIdentifier: cell.className
        )
    }
    
    func register(
        nib nibName: String,
        bundle: Bundle? = nil
    ) {
        self.register(
            UINib(
                nibName: nibName,
                bundle: bundle
            ),
            forCellReuseIdentifier: nibName
        )
    }
    
    func registerHeaderFooter(
        nib nibName: String,
        bundle: Bundle? = nil
    ) {
        register(
            UINib(
                nibName: nibName,
                bundle: bundle
            ),
            forHeaderFooterViewReuseIdentifier: nibName
        )
    }
    
    func registerHeaderFooter<T: UITableViewHeaderFooterView>(_ headerFooterView: T.Type) {
        register(
            headerFooterView.self,
            forHeaderFooterViewReuseIdentifier: headerFooterView.className
        )
    }
    
    func register(
        nibs nibNames: [String],
        bundle: Bundle? = nil
    ) {
        nibNames.forEach {
            self.register(
                UINib(
                    nibName: $0,
                    bundle: bundle
                ),
                forCellReuseIdentifier: $0
            )
        }
    }
    
    func register(
        nibs nibNames: [UITableViewCell],
        bundle: Bundle? = nil
    ) {
        nibNames.forEach {
            self.register(
                UINib(
                    nibName: $0.className,
                    bundle: bundle
                ),
                forCellReuseIdentifier: $0.className
            )
        }
    }
    
}
