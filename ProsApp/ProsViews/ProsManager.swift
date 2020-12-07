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
        let result = prosDataAccess.getProsDataFromBundle(fileName: "pro_data", fileExtension: "json")
        
        switch result {
        case .failure(let error):
            print(error)
        case .success(let value):
            prosManagerData = value.sorted{$0.companyName < $1.companyName}
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
