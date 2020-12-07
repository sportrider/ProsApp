//
//  ServiceExtensions.swift
//  ProsApp
//
//  Created by Gary Harris on 11/19/20.
//

import Foundation


public protocol EncoderType {
    func encode<T>(_ value: T) throws -> Data where T : Encodable
}
public protocol DecoderType {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
}

extension JSONEncoder: EncoderType {}
//extension PropertyListEncoder: EncoderType {}

extension JSONDecoder: DecoderType {}
//extension PropertyListDecoder: DecoderType {}


public extension Encodable {
    func encode(with encoder: EncoderType = JSONEncoder()) throws -> Data {
        return try encoder.encode(self)
    }
    
    func toString() -> String? {
        guard let data = try? self.encode() else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
}


public extension Decodable {
    static func decode<T>(from data: Data, with decoder: DecoderType = JSONDecoder()) throws -> T where T : Decodable {
        return try decoder.decode(T.self, from: data)
    }
}
