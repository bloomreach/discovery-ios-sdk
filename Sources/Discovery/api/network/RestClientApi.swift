//
//  File.swift
//  
//
//  Created by Prashant Bhujbal
//
import Foundation

public typealias CoreApiCompletion = (Result<CoreResponse, BrApiError>) -> Void

class RestClientApi {
    
    func doApiCall(components: URLComponents, success: @escaping (_ response: CoreResponse?) -> Void, failure: @escaping (_ error: BrApiError?) -> Void) {
        
//        var request = URLRequest(url: ((components.url ?? url)!))
        
        var request = URLRequest(url: ((components.url!)))
        print("url: \(request.url)"  )
        request.httpMethod = "GET"
        
       // request.setValue( "Bloomreach/1.0.0 " + System.getProperty("http.agent"), forHTTPHeaderField:  "User-Agent")
       
       // URLSession.
        
        let task = URLSession.shared.dataTask(with: request) { _data, response, error in
                    do {
                        let model = try JSONDecoder().decode(CoreResponse.self, from: _data!)
//                        completion(.success(model))
                        print(_data)
                        print(response)
                        print(" success")
                        success(model)
                    }
                    catch {
                        //completion(.failure(error))
                        print(" failure")
                       // completionHandler(.success)
                    }
        }
        task.resume()
    }
}
