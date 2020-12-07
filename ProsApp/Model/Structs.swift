//
//  Structs.swift
//  ProsApp
//
//  Created by Gary Harris on 11/19/20.
//

import Foundation

// MARK: - ProsData
public struct ProsData: Codable {
    let entityID, companyName, ratingCount, compositeRating: String
    let companyOverview: String
    let canadianSP, spanishSpeaking: Bool
    let phoneNumber: String
    let latitude, longitude: Double?
    let servicesOffered: String?
    let specialty: String? //Specialty
    let primaryLocation, email: String

    enum CodingKeys: String, CodingKey {
        case entityID = "entityId"
        case companyName, ratingCount, compositeRating, companyOverview, canadianSP, spanishSpeaking, phoneNumber, latitude, longitude, servicesOffered, specialty, primaryLocation, email
    }
}


public enum ProsDataResult<Value> {
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


public typealias ProsDataArray = [ProsData]


public struct SomeRequest: Codable {
    let someValue: String
    let someOtherValue: String
}

public struct SomeResponse: Codable {
    let errorCode: Int?
    let message: String?
    
    public enum CodingKeys: String, CodingKey {
        case errorCode = "errorCode"
        case message = "message"
    }
}

public struct SomeData: Codable {
    let data: Int
}
