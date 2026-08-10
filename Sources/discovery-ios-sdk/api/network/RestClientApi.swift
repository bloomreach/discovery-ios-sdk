//
//  RestClientApi.swift
//  
//
//  Class to perform API call for API module
//
import Foundation
import UIKit

class RestClientApi {
    
    /**
     Method to HTTP call for all Core API
     */
    func doApiCall(components: URLComponents, success: @escaping (_ response: CoreResponse?) -> Void, failure: @escaping (_ error: Error?) -> Void) {
        guard let url = components.url else {
            return failure(NSError(domain: "", code: 0))
        }
        print("API URL: \(url.absoluteString)")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(FormatterUtils.shared.getUserAgent(), forHTTPHeaderField:  "User-Agent")
  
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
                            print("Core API failure statusCode:  \(model.errorCode ?? 0)" )
                            print("Error: \(model.message ?? "")")
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
    
    /**
     Method to HTTP call for all Suggest API
     */
    func doApiCall(components: URLComponents, success: @escaping (_ response: SuggestResponse?) -> Void, failure: @escaping (_ error: Error?) -> Void) {
        guard let url = components.url else {
            return failure(NSError(domain: "", code: 0))
        }
        print("API URL: \(url.absoluteString)")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(FormatterUtils.shared.getUserAgent(), forHTTPHeaderField:  "User-Agent")
        
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
                            print("Core API failure statusCode:  \(model.errorCode ?? 0)" )
                            print("Error: \(model.message ?? "")")
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
    
    /**
     Method to HTTP call for all Recs and pathways API
     */
    func doApiCall(components: URLComponents, success: @escaping (_ response: RecsAndPathwaysResponse?) -> Void, failure: @escaping (_ error: Error?) -> Void) {
        guard let url = components.url else {
            return failure(NSError(domain: "", code: 0))
        }
        print("API URL: \(url.absoluteString)")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(FormatterUtils.shared.getUserAgent(), forHTTPHeaderField:  "User-Agent")
        
        //v2 API requires passing the auth-key as a request
        if let authKey = BrApi.shared.brApiRequest?.authKey {
            request.setValue(authKey, forHTTPHeaderField:  "auth_key")
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
                            print("Error: \(model.detail ?? "")")
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
    
    /**
     Method to HTTP call for all Upload Image for Visual Search API
     */
    func uploadImage(fileName: String, image: UIImage, components: URLComponents, success: @escaping (_ response: ImageUploadResponse?) -> Void, failure: @escaping (_ error: Error?) -> Void) {
        
        guard let url = components.url else {
            return failure(NSError(domain: "", code: 0))
        }
        print("API URL: \(url.absoluteString)")
        
        // Set the URLRequest to POST and to the specified URL
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue(FormatterUtils.shared.getUserAgent(), forHTTPHeaderField:  "User-Agent")
        
        //v2 API requires passing the auth-key as a request
        if let authKey = BrApi.shared.brApiRequest?.authKey {
            urlRequest.setValue(authKey, forHTTPHeaderField:  "auth_key")
        }
        
        // generate boundary string using a unique per-app string
        let boundary = UUID().uuidString

        // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
        // And the boundary is also set here
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var data = Data()

        // Add the image data to the raw http request data
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"image\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        data.append(image.pngData()!)

        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

        let session = URLSession.shared
        // Send a POST request to the URL, with the data we created earlier
        session.uploadTask(with: urlRequest, from: data, completionHandler: { _data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200..<300:
                    if let _data = _data {
                        do {
                            let model = try JSONDecoder().decode(ImageUploadResponse.self, from: _data)
                            print("Recs And Pathways API success:  \(httpResponse.statusCode)" )
                            success(model)
                            
                           // perfromVisualSearch(imageId: model.response?.imageId ?? "")
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
                            print("Error: \(model.detail ?? "")")
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
        }).resume()
    }
}
