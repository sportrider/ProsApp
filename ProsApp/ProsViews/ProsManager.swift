//
//  ProsManager.swift
//  ProsApp
//
//  Created by Gary Harris on 11/19/20.
//

import Foundation

// Allow only one instance of the data manager
public var sharedProsManager = ProsManager.shared

public class ProsManager: HasDependencies {
    
    lazy private var prosDataAccess: DataAccessProtocol = self.dependencies.resolveDataAccessService()
    lazy private var webService: WebServicesProtocol = self.dependencies.resolveWebService()
    
    private var prosManagerData = ProsDataArray()
    public static let shared = ProsManager()
    
    private init() {
        loadProsData()
    }
    
    var prosData: ProsDataArray {
        return prosManagerData
    }
    
    private func loadProsData() {
        let dataTuple = prosDataAccess.getProsDataFromBundle(fileName: "pro_data", fileExtension: "json")
        
        if let dataArray = dataTuple.0 {
            prosManagerData = dataArray.sorted{$0.companyName < $1.companyName}
        } else {
            // simplefied error handling
            print(dataTuple.1 ?? "Unknown error")
        }
    }
    
    func getData() {
        
        let someRequest = SomeRequest(someValue: "Merry Chrismas", someOtherValue: "Happy New Year")
        
        webService.postSomething(someRequest: someRequest) { (result) in
            DispatchQueue.main.async {
                if result.success {
                    
                } else {
                    //handle error
                }
            
            }
        }
    }

}
