//
//  LoginError.swift
//  Flicks
//
//  Created by Ricardo Pereira on 24/01/2020.
//  Copyright © 2020 Ricardo Pereira. All rights reserved.
//

import Foundation

enum LoginError: Int, Error, CustomStringConvertible {
    case missingSecret

    var description: String {
        switch self {
        case .missingSecret:
            return "Secret is missing"
        }
    }

}

extension LoginError: CustomNSError {

    static let errorDomain = Bundle.main.bundleIdentifier! + ".Login"

    var errorCode: Int {
        return Int(rawValue)
    }

    var errorUserInfo: [String : Any] {
        return [NSLocalizedDescriptionKey: description]
    }

}
