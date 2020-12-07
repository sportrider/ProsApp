//
//  WebServiceManager.swift
//  ProsApp
//
//  Created by Gary Harris on 12/7/20.
//

import Foundation

public enum WebServiceError: String, Error {
    case hostNotDefined = "Host URL not defined."
    case invalidDataForRequest = "Invalid data for request."
    case couldNotParseRequest = "Could not parse request."
    case undefined = "Undefined error."
    case noDataOnResponse = "No data returned on response"
    case invalidDataOnResponse = "Invalid data returned on response"
    case noUserIdInResponse = "No user id returned in response"
    case unexpectedResponseType = "Unexpected HTTP response type"
    case undefinedWebErrorResponse = "Undefined web error response"
    case couldNotStoreToken = "Could not store token"
    case noMemberIdInResponse = "No memberID in response."
}


public enum WebAPIHost {
    static let hostURL = "http://someAPIUrl.com/"
}

public enum WebAPIRoute: String {
    case someRoute = "some/apiRoute"
}

public class WebServicesManager: WebServicesProtocol, HasDependencies {
    private let session: WebServiceSession

    init(session: URLSession = .shared) {
        self.session = session
    }
    
    
    private func postRequest<T: Encodable>(route: WebAPIRoute, body: T? = nil, result: @escaping (_ data: Data?, _ httpStatus:Int?, _ error: Error?) -> Void) {
        
        guard let url = URL(string: WebAPIHost.hostURL) else {
            result(nil, nil, WebServiceError.hostNotDefined)
            return
        }
        
        let encoder = JSONEncoder()
        var requestData: Data?
        
        if let _ = body {
            do {
                requestData = try encoder.encode(body)
            } catch {
                result(nil, nil, WebServiceError.invalidDataForRequest)
            }
            
            guard let _ = requestData else {
                result(nil, nil, WebServiceError.invalidDataForRequest)
                return
            }
        } else {
            requestData = nil  // post with empty body
        }
        
        var request = URLRequest(url: url.appendingPathComponent(route.rawValue))
        
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")  // the request in JSON
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")        // the expected response is also

        request.httpMethod = "POST"
        request.httpBody = requestData
        
        session.processRequest(url: request) {
            data, response, err in
            
             guard let httpResponse = response as? HTTPURLResponse else {
                result(nil, nil, WebServiceError.unexpectedResponseType)
                return
            }
            
            if httpResponse.statusCode > 299 {  // check for network error... business logic errors checked later... gjh
                result(data, httpResponse.statusCode,  WebServiceError.unexpectedResponseType)
                return
            }
            
            result(data, httpResponse.statusCode, err)
            return
        }
    }
    
     private func getRequest(queryItems: URLQueryItem? = nil, route: WebAPIRoute, authToken: String? = nil, result: @escaping (_ data: Data?, _ httpStatus:Int?, _ error: Error?) -> Void) {
        getRequest(queryItems: queryItems, routeString: route.rawValue, authToken: authToken, result: result)
    }
    
    
    private func getRequest(queryItems: URLQueryItem? = nil, routeString: String, authToken: String? = nil, result: @escaping (_ data: Data?, _ httpStatus:Int?, _ error: Error?) -> Void) {
        
        guard var urlComponents = URLComponents(string: WebAPIHost.hostURL.appending(routeString)) else {
            result(nil, nil, WebServiceError.hostNotDefined)
            return
        }
        
        if let items = queryItems {
            urlComponents.queryItems = [items]
        }
        
        guard let url = urlComponents.url else {
            result(nil, nil, WebServiceError.hostNotDefined)
            return
        }
        
        var request = URLRequest(url: url)
        
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")  // the request in JSON
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")        // the expected response is also
             
        request.httpMethod = "GET"
        
        
        session.processRequest(url: request) {
            data, response, err in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                result(nil, nil, WebServiceError.unexpectedResponseType)
                return
            }
            
            if  httpResponse.statusCode > 299 {  // check for network error... business logic errors checked later... gjh
                result(nil, httpResponse.statusCode,  WebServiceError.unexpectedResponseType)
                return
            }
            
            if (err != nil) {
                result(nil, httpResponse.statusCode, err)
                return
            } else {
                result(data, httpResponse.statusCode, nil)
                return
            }
        }
    }
    

    public func postSomething(someRequest: SomeRequest, completion: @escaping (_ result: WebServiceResult<Bool>) -> Void) {
        
        postRequest(route: .someRoute, body: someRequest) { (data, httpStatus, error) in
            
            guard let data = data else {
                completion(WebServiceResult.failure(WebServiceError.noDataOnResponse))
                return
            }
            
            let someResponse: SomeResponse?
            do {
                someResponse = try SomeResponse.decode(from: data)
                if let _ = someResponse?.errorCode {
                    completion(WebServiceResult.failure(WebServiceError.undefined))
                    return
                }
            } catch let error {
                //handle error
                print(error)
                completion(WebServiceResult.failure(WebServiceError.invalidDataOnResponse))
                return
            }
            
            if error != nil {
                completion(WebServiceResult.failure(WebServiceError.undefined))
            } else {
                completion(WebServiceResult.success(true))
            }
        }
    }
    
}
