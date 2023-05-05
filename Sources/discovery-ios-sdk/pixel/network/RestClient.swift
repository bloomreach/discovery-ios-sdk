//
//  RestClient.swift
//  
//
//  RestClient class to perform API call in the SDK
//

import Foundation

class RestClient {
    
    func validatePixel (postBody: [String: Any]) {
        let url = URL(string: "https://tools.bloomreach.com/pixel-validator/validatePixel")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        if let requestBody = getParameterBody(with: postBody) {
            request.httpBody = requestBody
        }
        
        let task = URLSession.shared.dataTask(with: request) { _data, response, error in
            do {
                let model = try JSONDecoder().decode(PixelValidatorResponse.self, from: _data!)
                self.printPixelValidatorResponse(response: model)
            }
            catch {
                print("validatePixel failure")
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
        let baseUrl = PixelTracker.shared.brPixel?.pixelUrlByRegion
        let url = URL(string: "https://\(baseUrl)/pix.gif")
        var components = URLComponents(string: url!.absoluteString)!
        components.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        
        var request = URLRequest(url: ((components.url ?? url)!))
        request.httpMethod = "GET"
        request.setValue("Bloomreach/1.0.0 iOS", forHTTPHeaderField:  "User-Agent")
        
        // URLSession.
        let task = URLSession.shared.dataTask(with: request) { _data, response, error in
            do {
                print("submitPixel success")
            }
            catch {
                print("submitPixel failure")
            }
        }
        task.resume()
        
        
    }
    
    
    private func printPixelValidatorResponse(response: PixelValidatorResponse?){
        if (response == nil) {
            return
        }
        
        if (response!.errors != nil && !response!.errors.isEmpty) {
            print(
                "Pixel Validator",
                "\n==========PIXEL VALIDATOR ERROR========= \n\n\(formResponseString(response: response!)) \n\n"
            )
        } else if (response!.warns != nil && !response!.warns.isEmpty) {
            print(
                "Pixel Validator",
                "\n==========PIXEL VALIDATOR WARNING========= \n\n\(formResponseString(response: response!)) \n\n"
            )
        } else {
            print(
                "Pixel Validator",
                "\n==========PIXEL VALIDATOR SUCCESS========= \n\n\(formResponseString(response: response!)) \n\n"
            )
        }
    }
    
    private func formResponseString(response: PixelValidatorResponse) -> String {
        var printString = "Pixel Name: \(response.displayName)\n\n"
        
        if (response.errors != nil && !response.errors.isEmpty) {
            printString.append("Error in Parameters ==>")
            for error in response.errors {
                printString.append("\(error.name): \(error.value)\n")
                printString.append("Description: \(error.description)\n\n")
            }
        }
        
        if (response.warns != nil && !response.warns.isEmpty) {
            printString.append("Warning in Parameters ==>\n")
            for warn in response.warns {
                printString.append("\(warn.name): \(warn.value)\n")
                printString.append("Description: \(warn.description)\n\n")
            }
        }
        
        if (response.success != nil && !response.success.isEmpty) {
            printString.append("Success Parameters ==>\n")
            for success in response.success {
                printString.append("\(success.name): \(success.value)\n")
            }
        }
        return printString
    }
}
