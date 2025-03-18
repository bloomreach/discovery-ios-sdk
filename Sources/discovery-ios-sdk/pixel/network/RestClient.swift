//
//  RestClient.swift
//  
//
//  RestClient class to perform API call in the SDK
//

import Foundation

class RestClient {
    
    func validatePixel (postBody: [String: Any]) {
        guard let url = URL(string: "https://tools.bloomreach.com/pixel-validator/validatePixel") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        if let requestBody = getParameterBody(with: postBody) {
            request.httpBody = requestBody
        }
        
        let task = URLSession.shared.dataTask(with: request) { _data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200..<300:
                    if let _data = _data {
                        do {
                            let model = try JSONDecoder().decode(PixelValidatorResponse.self, from: _data)
                            self.printPixelValidatorResponse(response: model)
                        }
                        catch let error {
                            print("validatePixel failure \(httpResponse.statusCode)")
                            print("Error: \(error)")
                        }
                    } else {
                        print("validatePixel failure \(httpResponse.statusCode)")
                        print("Error: No Data")
                    }
                default:
                    print("validatePixel failure \(httpResponse.statusCode)")
                }
            }
        }
        task.resume()
    }
    
    private func getParameterBody(with parameters: [String:Any]) -> Data? {
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) else {
            return nil
        }
        return httpBody
    }
    
    func submitPixel(parameters: [String: String?]) {
        guard let baseUrl = PixelTracker.shared.brPixel?.pixelUrlByRegion,
              let url = URL(string: "https://\(baseUrl)/pix.gif"),
              var components = URLComponents(string: url.absoluteString)
              else {
                    return
                }
        components.queryItems = parameters.map { (key, value) in
                URLQueryItem(name: key, value: value)
        }
        
        guard let urlRequest = components.url else { return }
        
        var request = URLRequest(url: urlRequest)
        if (PixelTracker.shared.brPixel!.debugMode) {
            print("url: \(String(describing: request.url))")
        }
        request.httpMethod = "GET"
        request.setValue(FormatterUtils.shared.getUserAgent(), forHTTPHeaderField:  "User-Agent")

        
        // URLSession.
        let task = URLSession.shared.dataTask(with: request) { _data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200..<300:
                    if (PixelTracker.shared.brPixel!.debugMode) {
                        print("submitPixel success \(httpResponse.statusCode)")
                    }
                default:
                    if (PixelTracker.shared.brPixel!.debugMode) {
                        print("submitPixel failure \(httpResponse.statusCode)")
                    }
                }
            }
        }
        task.resume()
    }
    
    
    private func printPixelValidatorResponse(response: PixelValidatorResponse?){
        guard let response = response else {
            return
        }
        if let error = response.errors, !error.isEmpty {
            print(
                "Pixel Validator",
                "\n==========PIXEL VALIDATOR ERROR========= \n\n\(formResponseString(response: response)) \n\n"
            )
        }
        else if let warn = response.warns, !warn.isEmpty {
            print(
                "Pixel Validator",
                "\n==========PIXEL VALIDATOR WARNING========= \n\n\(formResponseString(response: response)) \n\n"
            )
        }
        else {
            print(
                "Pixel Validator",
                "\n==========PIXEL VALIDATOR SUCCESS========= \n\n\(formResponseString(response: response)) \n\n"
            )
        }
    }
    
    private func formResponseString(response: PixelValidatorResponse) -> String {
        var printString = "Pixel Name: \(response.displayName ?? "")\n\n"
        if let errors = response.errors, !errors.isEmpty {
            printString.append("Error in Parameters ==>")
            for error in errors {
                printString.append("\(error.name ?? ""): \(error.value ?? "")\n")
                printString.append("Description: \(error.description ?? "")\n\n")

            }
        }
        
        if let warns = response.warns, !warns.isEmpty {
            printString.append("Warning in Parameters ==>\n")
            for warn in warns {
                printString.append("\(warn.name ?? ""): \(warn.value ?? "")\n")
                printString.append("Description: \(warn.description ?? "")\n\n")
            }
        }
        
        if let successes = response.success, !successes.isEmpty {
            printString.append("Success Parameters ==>\n")
            for success in successes {
                printString.append("\(success.name ?? ""): \(success.value ?? "")\n")
            }
        }
        return printString
    }
}
