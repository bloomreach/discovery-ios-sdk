//
//  RestClientApi.swift
//  
//
//  Class to perform API call for API module
//
import Foundation


class RestClientApi {
    
    /**
     Method to HTTP call for all API
     */
    func doApiCall(components: URLComponents, success: @escaping (_ response: CoreResponse?) -> Void, failure: @escaping (_ error: Error?) -> Void) {
        var request = URLRequest(url: ((components.url!)))
        request.httpMethod = "GET"
        request.setValue("Bloomreach/1.0.0 iOS", forHTTPHeaderField:  "User-Agent")
        // URLSession.
        
        let task = URLSession.shared.dataTask(with: request) { _data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200..<300:
                    if let _data = _data {
                        do {
                            let model = try JSONDecoder().decode(CoreResponse.self, from: _data)
                            print("Core API success:  \(httpResponse.statusCode)" )
                            success(model)
                        }
                        catch let error {
                            print("Core API failure \(httpResponse.statusCode)")
                            print("Error: \(error)")
                            failure(NSError(domain: "", code: httpResponse.statusCode))
                        }
                    } else {
                        print("Core API failure \(httpResponse.statusCode)")
                        print("Error: No Data")
                        failure(NSError(domain: "NoData", code: httpResponse.statusCode))
                    }
                    
                default:
                    print("Core API failure \(httpResponse.statusCode)")
                    if let _data = _data {
                        do {
                            let model = try JSONDecoder().decode(BrApiError.self, from: _data)
                            print("Core API failure statusCode:  \(String(describing: model.errorCode))" )
                            print("Error: \(String(describing: model.message))")
                        }
                        catch let error {
                            print("Error: \(error)")
                        }
                        failure(NSError(domain: "", code: httpResponse.statusCode))
                    } else {
                        print("Error: No Data")
                        failure(NSError(domain: "NoData", code: httpResponse.statusCode))
                    }
                }
            }
        }
        task.resume()
    }
    
    func doApiCall(components: URLComponents, success: @escaping (_ response: SuggestResponse?) -> Void, failure: @escaping (_ error: Error?) -> Void) {
        var request = URLRequest(url: ((components.url!)))
        request.httpMethod = "GET"
        request.setValue("Bloomreach/1.0.0 iOS", forHTTPHeaderField:  "User-Agent")
        
        // URLSession.
        let task = URLSession.shared.dataTask(with: request) { _data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200..<300:
                    if let _data = _data {
                        do {
                            let model = try JSONDecoder().decode(SuggestResponse.self, from: _data)
                            print("Suggest API success:  \(httpResponse.statusCode)" )
                            success(model)
                        }
                        catch {
                            print("Suggest API failure \(httpResponse.statusCode)")
                            print("Error: \(error)")
                            failure(NSError(domain: "", code: httpResponse.statusCode))
                        }
                    } else {
                        print("Suggest API failure \(httpResponse.statusCode)")
                        print("Error: No Data")
                        failure(NSError(domain: "NoData", code: httpResponse.statusCode))
                    }
                default:
                    print("Suggest API failure \(httpResponse.statusCode)")
                    if let _data = _data {
                        do {
                            let model = try JSONDecoder().decode(BrApiError.self, from: _data)
                            print("Core API failure statusCode:  \(String(describing: model.errorCode))" )
                            print("Error: \(String(describing: model.message))")
                        }
                        catch let error {
                            print("Error: \(error)")
                        }
                        failure(NSError(domain: "", code: httpResponse.statusCode))
                    } else {
                        print("Error: No Data")
                        failure(NSError(domain: "NoData", code: httpResponse.statusCode))
                    }
                    
                }
            }
        }
        task.resume()
    }
    
    func doApiCall(components: URLComponents, success: @escaping (_ response: RecsAndPathwaysResponse?) -> Void, failure: @escaping (_ error: Error?) -> Void) {
        var request = URLRequest(url: ((components.url!)))
        request.httpMethod = "GET"
        request.setValue("Bloomreach/1.0.0 iOS", forHTTPHeaderField:  "User-Agent")
        
        //v2 API requires passing the auth-key as a request
        if(BrApi.shared.brApiRequest?.authKey != nil) {
            request.setValue(BrApi.shared.brApiRequest?.authKey, forHTTPHeaderField:  "auth_key")
        }
        // URLSession.
        
        let task = URLSession.shared.dataTask(with: request) { _data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200..<300:
                    if let _data = _data {
                        do {
                            let model = try JSONDecoder().decode(RecsAndPathwaysResponse.self, from: _data)
                            print("Recs And Pathways API success:  \(httpResponse.statusCode)" )
                            success(model)
                        }
                        catch {
                            print("Recs And Pathways API failure \(httpResponse.statusCode)")
                            print(error)
                            failure(NSError(domain: "", code: httpResponse.statusCode))
                        }
                    } else {
                        print("Recs And Pathways API failure \(httpResponse.statusCode)")
                        print("Error: No Data")
                        failure(NSError(domain: "NoData", code: httpResponse.statusCode))
                    }
                default:
                    print("Recs And Pathways API failure \(httpResponse.statusCode)")
                    if let _data = _data {
                        do {
                            let model = try JSONDecoder().decode(RpError.self, from: _data)
                            print("Error: \(String(describing: model.detail))")
                        }
                        catch let error {
                            print("Error: \(error)")
                        }
                        failure(NSError(domain: "", code: httpResponse.statusCode))
                    } else {
                        print("Error: No Data")
                        failure(NSError(domain: "NoData", code: httpResponse.statusCode))
                    }
                }
            }
        }
        task.resume()
    }
}
