//
//  WebServiceSession.swift
//  ProsApp
//
//  Created by Gary Harris on 12/7/20.
//

import Foundation

public protocol WebServiceSession {
    func processRequest(url: URLRequest, result: @escaping(Data?, URLResponse?, Error?) -> Void)
}

extension URLSession: WebServiceSession {
    
    public func processRequest(url: URLRequest, result: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        dataTask(with: url) { (data, response, error) in
            result(data, response, error)
            }.resume()
    }
}

class NetworkSessionMock: WebServiceSession {
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    func processRequest(url: URLRequest, result: @escaping (Data?, URLResponse?, Error?) -> Void) {
        result(data, response, error)
    }
}
