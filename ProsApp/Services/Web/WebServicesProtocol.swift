//
//  WebServicesProtocol.swift
//  ProsApp
//
//  Created by Gary Harris on 12/7/20.
//

import Foundation


public protocol ServiceProtocol {
}

public protocol RemoteServiceProtocol: ServiceProtocol {
}

public protocol WebServicesProtocol: RemoteServiceProtocol {
   func postSomething(someRequest: SomeRequest, completion: @escaping (_ result: WebServiceResult<Bool>) -> Void)
}
