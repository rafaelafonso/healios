//
//  Network.swift
//  Healios
//
//  Created by Rafael Afonso on 12/6/21.
//

import Foundation
import Alamofire

class Network {
    
    static let shared = Alamofire.Session()
    
    static func request<ResponseData: Decodable>(_ convertible: URLConvertible, authenticated: Bool = true, method: HTTPMethod = .get, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = nil, completionHandler: @escaping (Result<ResponseData, Error>) -> Void) {
        Network.shared
            .request(
                convertible,
                method: method,
                parameters: parameters,
                encoding: encoding,
                headers: headers)
            .validate()
            .responseDecodable { Self.responseCompletion(response: $0, completionHandler: completionHandler) }
    }
    
    private static func responseCompletion<ResponseData: Decodable>(response: AFDataResponse<ResponseData>, completionHandler: @escaping (Result<ResponseData, Error>) -> Void) {
        completionHandler(response.result.mapError { error in
            return error
        })
    }
}
