//
//  DataAccessService.swift
//  ProsApp
//
//  Created by Gary Harris on 11/19/20.
//

import Foundation

// Enums for simplified error handling
public enum DataReadWriteError: String {
    case couldNotOpenFile = "Could not open file"
    case couldNotReadData = "Could not read data"
    case couldNotDecodeData = "Could not decode data"
}

public class DataAccessService: DataAccessProtocol {
    
    public func getProsDataFromBundle(fileName: String, fileExtension: String) -> (ProsDataArray?, String?) {

        if let url = Bundle.main.path(forResource: fileName, ofType: fileExtension) {
            do {
                let fileContent = try String(contentsOfFile: url)
                
                guard let data = fileContent.data(using: .utf8) else {
                    return (nil, DataReadWriteError.couldNotReadData.rawValue)
                }

                let prosDataArray: ProsDataArray = try ProsDataArray.decode(from: data)
                return (prosDataArray, nil)
                
            } catch {
                return (nil, DataReadWriteError.couldNotDecodeData.rawValue)
            }
        }
        
        return (nil, DataReadWriteError.couldNotOpenFile.rawValue)
    }
    
}
