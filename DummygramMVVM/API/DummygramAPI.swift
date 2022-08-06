//
//  DummygramAPI.swift
//  DummygramMVVM
//
//  Created by Bagas Ilham on 04/08/22.
//

import Foundation
import Alamofire

struct DummygramAPI {
    static let shared = DummygramAPI()
    let baseUrl: String = "https://dummyapi.io/data/v1/"
    let appId: String = "62ed142271fc22563d774032"
    
    func getPosts(
        _ completion: @escaping (DGDataResponse<DGPostResponse>?, AFError?) -> Void
    ) {
        let headers: HTTPHeaders = ["app-id" : appId]
        AF.request(
            baseUrl + "post",
            method: .get,
            headers: headers
        )
            .validate()
            .responseDecodable(of: DGDataResponse<DGPostResponse>.self) { response in
                switch response.result {
                case let .success(data):
                    completion(data, nil)
                case let .failure(error):
                    completion(nil, error)
                    print(error)
                }
            }
    }
    
    func getPost(
        _ postId: String,
        _ completion: @escaping (DGPostResponse?, AFError?) -> Void
    ) {
        let headers: HTTPHeaders = ["app-id" : appId]
        AF.request(
            baseUrl + "post/\(postId)",
            method: .get,
            headers: headers
        )
            .validate()
            .responseDecodable(of: DGPostResponse.self) { response in
                switch response.result {
                case let .success(data):
                    completion(data, nil)
                case let .failure(error):
                    completion(nil, error)
                    print(error)
                }
            }
    }
    
    func getComments(
        _ postId: String,
        _ completion: @escaping (DGDataResponse<DGCommentResponse>?, AFError?) -> Void
    ) {
        let headers: HTTPHeaders = ["app-id" : appId]
        AF.request(
            baseUrl + "post/\(postId)/comment",
            method: .get,
            headers: headers
        )
            .validate()
            .responseDecodable(of: DGDataResponse<DGCommentResponse>.self) { response in
                switch response.result {
                case let .success(data):
                    completion(data, nil)
                case let .failure(error):
                    completion(nil, error)
                    print(error)
                }
            }
    }
}
