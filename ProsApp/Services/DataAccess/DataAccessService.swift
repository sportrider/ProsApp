//
//  DataAccessService.swift
//  ProsApp
//
//  Created by Gary Harris on 11/19/20.
//

import Foundation

// Enums for simplified error handling
public enum DataReadWriteError: String, Error {
    case couldNotOpenFile = "Could not open file"
    case couldNotReadData = "Could not read data"
    case couldNotDecodeData = "Could not decode data"
}

public class DataAccessService: DataAccessProtocol {
    
    public func getProsDataFromBundle(fileName: String, fileExtension: String) -> ProsDataResult<ProsDataArray> {

        if let url = Bundle.main.path(forResource: fileName, ofType: fileExtension) {
            do {
                let fileContent = try String(contentsOfFile: url)
                
                guard let data = fileContent.data(using: .utf8) else {
                    return (ProsDataResult.failure(DataReadWriteError.couldNotReadData))
                }

                let prosDataArray: ProsDataArray = try ProsDataArray.decode(from: data)
                return (ProsDataResult.success(prosDataArray))
                
            } catch {
                return (ProsDataResult.failure(DataReadWriteError.couldNotDecodeData))
            }
        }
        
        return (ProsDataResult.failure(DataReadWriteError.couldNotOpenFile))
    }
    
}
