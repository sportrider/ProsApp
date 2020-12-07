//
//  ServiceExtensions.swift
//  ProsApp
//
//  Created by Gary Harris on 11/19/20.
//

import Foundation

// For the convenience of decoding json

public protocol DecoderType {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
}


extension JSONDecoder: DecoderType {}

public extension Decodable {
    static func decode<T>(from data: Data, with decoder: DecoderType = JSONDecoder()) throws -> T where T : Decodable {
        return try decoder.decode(T.self, from: data)
    }
}
