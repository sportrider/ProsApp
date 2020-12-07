//
//  ServiceFactory.swift
//  ProsApp
//
//  Created by Gary Harris on 11/19/20.
//
import Foundation

public protocol ServiceFactory {
    func resolveWebService() -> WebServicesProtocol
    func resolveDataAccessService() -> DataAccessProtocol
}

open class CoreServicesContainer: ServiceFactory {
    public init() {}
    
    open func resolveWebService() -> WebServicesProtocol {
        return WebServicesManager()
    }
    
    open func resolveDataAccessService() -> DataAccessProtocol {
        return DataAccessService()
    }
}

// DependencyInjector is a singleton entity that ensures default service implementations are initialized and made
// available at the time of application initialization.


public struct DependencyInjector {
    public static var dependencies: ServiceFactory = CoreServicesContainer()
    private init() {}
}


// Protocol HasDependencies and its extension provide the definition and default implementation of *dependencies* property
// that can serve as an interface for injecting custom service implementations when required.


public protocol HasDependencies {
    var dependencies: ServiceFactory { get }
}

public extension HasDependencies {
    var dependencies: ServiceFactory {
        return DependencyInjector.dependencies
    }
}
