//
//  WebServiceResult.swift
//  ProsApp
//
//  Created by Gary Harris on 12/7/20.
//

import Foundation


public enum WebServiceResult<Value> {
    case success(Value)
    case failure(Error)
    
    public var success: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }
    
    /// Returns the associated value if the result is a success, `nil` otherwise.
    public var value: Value? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }
    
    /// Returns the associated error value if the result is a failure, `nil` otherwise.
    public var error: Error? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
}
