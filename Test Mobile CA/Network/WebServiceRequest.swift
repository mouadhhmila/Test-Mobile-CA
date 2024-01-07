//
//  WebServiceRequest.swift
//  Test Mobile CA
//
//  Created by Mouadh Hmila on 5/1/2024.
//

import Foundation
import Alamofire
import UIKit

public struct WebServiceRequest {
    
    
    
    
    static func callWebService<T:Codable>(loader : Bool , event : String , header : HTTPHeaders, method: HTTPMethod, completion:@escaping (T? , Bool) ->()){
        
        if DataViewModel.isConnectedToNetwork() {
            
            AF.request(event ,
                       method: method,
                       encoding: JSONEncoding.default,
                       headers: header)
            { $0.timeoutInterval = 10 }
                .validate(statusCode: 200...401)
                .responseJSON { (response) in
                    
                    do {
                        
                        let result = response.result
                        switch result {
                        case .success:
                            
//                            print("success service response : " + String(decoding: response.data!, as: UTF8.self))
//                            print("*******-------********")
                            
                            let responseWs  = try JSONDecoder().decode(T.self, from: response.data!)
                            completion(responseWs, false)
                            
                        case .failure:
                            
//                            print("failure service response : " + String(decoding: response.data!, as: UTF8.self))
//                            print("*******-------********")
                            
                            completion(nil, true)
                            
                            
                        }
                        
                    }
                    catch {
                        print("catch", error)
                        completion(nil, true)
                    }
                    
                    
                }
        } else {
            print("isNotConnected")
            completion(nil, true)
            
        }
    }
    
    
}
