//
//  NewsApiService.swift
//  VideoTracker
//
//  Created by Кирилл Худяков on 19.07.2020.
//  Copyright © 2020 Татьяна Севостьянова. All rights reserved.
//

import Alamofire


enum APIRequests: URLRequestConvertible {
    
    case getNews(token: String)
    
    func asURLRequest() throws -> URLRequest {
        guard let baseUrl = URL(string: K.baseHost) else {
            fatalError("error Request")
        }
        
        switch self {
        case let .getNews(token):
            var urlRequest = URLRequest(url: baseUrl.appendingPathComponent("video-tracker/"))
            urlRequest.headers = [.accept("application/json"),
                                  .contentType("application/json"),
                                  .authorization(bearerToken: token)]
            urlRequest.method = .get
            return urlRequest
        }
    }
    
}



final class NewsApiService: NewsService {
    
    func getNewsItems(_ completion: (Result<[NewsItem], Error>) -> Void) {
        AF
            .request(APIRequests.getNews(token: "1097117"))
            .responseString { result in
                print(result)
        }
    }
    
}

