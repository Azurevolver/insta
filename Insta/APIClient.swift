//
//  APIClient.swift
//  Insta
//
//  Created by YuanChingChen on 2023/7/15.
//

import Foundation
import Combine

enum APIError: Error {
    case requestFailed(Int)
    case postProcessingFailed(Error?)
}

struct APIClient {
    let session: URLSession
    let environment: APIEnvironment
    
    // use URLSession singleton
    init(session: URLSession = .shared, environment: APIEnvironment = .prod) {
        self.session = session
        self.environment = environment
    }
    
    // combine publisher
    /*
     The purpose of <T: APIRequest> in this context is to ensure that the argument request passed to the function is of a type that conforms to the APIRequest protocol. By using this generic type constraint, the function can work with any type that conforms to APIRequest, allowing for flexibility and reusability.
     */
    func publisherForRequest<T: APIRequest>(_ request: T) -> AnyPublisher<T.Response, Error> {
        let url = environment.baseUrl.appendingPathComponent(request.path)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        
        let publisher = session.dataTaskPublisher(for: urlRequest)
            .tryMap { (data: Data, response: URLResponse) in
                guard let httpResponse = response as? HTTPURLResponse
                        else {
                    throw APIError.requestFailed(0)
                }
                
                // check status code
                let statusCode = httpResponse.statusCode
                if 200..<300 ~= statusCode {
                    throw APIError.requestFailed(statusCode)
                }
                
                return data
            }
            .tryMap{ data -> T.Response in
                try request.handle(response: data)
                
            }
            // handle 前面所有可能發生過的 error
            .tryCatch { error -> AnyPublisher<T.Response, APIError> in
                throw APIError.postProcessingFailed(error)
            }
            // 確保接下來的處理都在main thread
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
                                                  
        return publisher
    }
}
