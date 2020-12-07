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
