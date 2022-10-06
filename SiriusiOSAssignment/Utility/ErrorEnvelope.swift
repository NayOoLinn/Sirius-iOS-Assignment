//
//  ErrorEnvelope.swift
//  SiriusiOSAssignment
//
//  Created by Nay Oo Linn on 06/10/2022.
//

import Foundation

enum ErrorEnvelope: Error {
    case error(Error)
    case message(String)
    
    var description: String {
        switch self {
        case .error(let error):
            return error.localizedDescription
        case .message(let error):
            return error
        }
    }
}
