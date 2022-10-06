//
//  UIStoryboard.swift
//  SiriusiOSAssignment
//
//  Created by Nay Oo Linn on 06/10/2022.
//

import UIKit

public protocol Storyboarded {
    static var storyboardName: String { get set }
    static func instantiate(from bundle: Bundle) -> Self
}

extension Storyboarded where Self: UIViewController {
    public static func instantiate(from bundle: Bundle = Bundle.main) -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: Self.className) as! Self
    }
}
