//
//  DataAccessProtocol.swift
//  ProsApp
//
//  Created by Gary Harris on 11/19/20.
//

import Foundation

// Protocols for data access
// These can include web services, CoreData, filesystem, etc.

public protocol DataAccessProtocol {
    func getProsDataFromBundle(fileName: String, fileExtension: String) -> ProsDataResult<ProsDataArray>
}
