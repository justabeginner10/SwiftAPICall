//
//  TypedThrowsExample.swift
//  PracticeProject
//
//  Created by Aditya on 21/08/24.
//

import Foundation
import UIKit

enum ExpectedErrors: Error {
    case urlInvalid
    case errorWhileCalling
    case responseError
    case responseErrorWithCode(Int)
    case dataConverionError
    case dataParsingError
}


public func foo(completion: @escaping (Result<[String: Any], Error>) -> Void)  {
    let urlString = ""
    guard let url = URL(string: urlString)
    else {
        completion(.failure(ExpectedErrors.urlInvalid))
        return
    }
    
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "GET"
    
    let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
        guard let error
        else {
            completion(.failure(ExpectedErrors.errorWhileCalling))
            return
        }
        
        guard let response = response as? HTTPURLResponse
        else {
            completion(.failure(ExpectedErrors.responseError))
            return
        }
        
        guard (200...299).contains(response.statusCode)
        else {
            completion(.failure(ExpectedErrors.responseErrorWithCode(response.statusCode)))
            return
        }
        
        guard let data =  data else {
            completion(.failure(ExpectedErrors.dataConverionError))
            return
        }
        
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                completion(.success(json))
            } else {
                completion(.failure(ExpectedErrors.dataParsingError))
            }
        } catch {
            completion(.failure(ExpectedErrors.dataParsingError))
        }
    }
    
    task.resume()
}
