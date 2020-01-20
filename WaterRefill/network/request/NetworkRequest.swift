//
//  NetworkRequest.swift
//  WaterRefill
//
//  Created by Jithin on 20/01/20.
//  Copyright © 2020 FabCoders. All rights reserved.
//

import UIKit
import Alamofire

class NetworkRequest<Model>: NSObject {
    
    let ROOT_URL = "http://fabcoders.com/waterrefillpoints"
    let SUB_PATH = "/index.php/API/ApiCaller/"
    
    let concurrentQueue:DispatchQueue = {
        return  DispatchQueue(label: "alamofire.concurrent", qos:.userInitiated, attributes: [.concurrent])
    }()
    
    var URL:String!
    var httpMethod:HTTPMethod = HTTPMethod.get
    var parameters:[String:String]  = [String:String]()
    var headers:HTTPHeaders = HTTPHeaders()
    
    
    func addParams(_ reqParams:[String:String]){
        for (key,value) in reqParams{
            parameters[key] = value
        }
    }
    
    func addHeaders(_ reqHeaders:[String:String]){
        for (key,value) in reqHeaders{
            let header = HTTPHeader(name: key, value: value)
            headers.add(header)
        }
    }
    
    
    func load(withCompletion completion: @escaping (Model?) -> Void){
        AF.request(URL,method:httpMethod,parameters:parameters,
                   headers:headers).validate().responseJSON(queue: concurrentQueue) { (responseData) in
                    switch responseData.result{
                    case .success:
                        if let data = responseData.data{
                            let parsedData = self.parse(data)
                            DispatchQueue.main.async {
                                completion(parsedData)
                            }
                        }
                    case .failure:
                        DispatchQueue.main.async {
                            completion(nil)
                        }
                    }
        }
    }
    
    
    func load(withCompletion completion: @escaping ([Model]) -> Void){
        AF.request(URL,method:httpMethod,parameters:parameters,
                   headers:headers).validate().responseJSON(queue: concurrentQueue) { (responseData) in
                    switch responseData.result{
                    case .success:
                        if let data = responseData.data{
                            let parsedData = self.parseForArray(data)
                            DispatchQueue.main.async {
                                completion(parsedData)
                            }
                        }
                    case .failure:
                        DispatchQueue.main.async {
                            completion([])
                        }
                    }
        }
        
    }
    
    func parse(_ data:Data) -> Model?{
        return nil
    }
    
    func parseForArray(_ data:Data) -> [Model]{
        return []
    }
    
    func getBaseUrl() -> String{
        return ROOT_URL + SUB_PATH
    }
    
}
