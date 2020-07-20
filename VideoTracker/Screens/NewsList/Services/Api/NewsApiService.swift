//
//  NewsApiService.swift
//  VideoTracker
//
//  Created by Кирилл Худяков on 19.07.2020.
//  Copyright © 2020 Татьяна Севостьянова. All rights reserved.
//

import Alamofire




fileprivate struct NewsItemDecodable: Decodable {
    let videoLink: String
    let videoCover: String
    let title: String
    let likes: Int
    let views: Int
    let avatar: String
    let publishDate: Int64
}

fileprivate struct NewsResponseDecodable: Decodable {
    let list: [NewsItemDecodable]
    let error: String?
}


final class NewsApiService: NewsService {
    
    func getNewsItems(_ completion: @escaping (Result<[NewsItem], Error>) -> Void) {
        AF
            .request(APIRequests.getNews(token: "1097117"))
            .responseDecodable { (response: AFDataResponse<NewsResponseDecodable>) in
                switch response.result {
                case let(model):
                    do {
                    let items = try model.map { $0.list.map { NewsItem(video: VideoItem(image: UIImage(imageLiteralResourceName: $0.videoCover),
                        videoUrl: URL(string: $0.videoLink)),
                        avatar: UIImage(imageLiteralResourceName: $0.avatar),
                        title: $0.title,
                        publishDate: Date.init(timeIntervalSince1970: TimeInterval($0.publishDate)),
                        likes: $0.likes,
                        views: $0.views,
                        isLiked: false,
                        inBookmarks: false) }}.get()
                        completion(.success(items))
                    } catch {
                        completion(.failure(error))
                    }
                }
                
                
        }
    }
    
}

