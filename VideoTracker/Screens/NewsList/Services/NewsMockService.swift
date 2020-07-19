//
//  NewsMockService.swift
//  VideoTracker
//
//  Created by Кирилл Худяков on 19.07.2020.
//  Copyright © 2020 Татьяна Севостьянова. All rights reserved.
//

import Foundation


class NewsMockService: NewsService {
    
    func getNewsItems(_ completion: @escaping (Result<[NewsItem], Error>) -> Void)  {
        completion(.success([
            .init(video: VideoItem.init(image: .video1, videoUrl: URL(string: "https://firebasestorage.googleapis.com/v0/b/pitchit-f0ab2.appspot.com/o/uploads%2Fproducts%2F3MQwiMjYXy5uKBo2ZlxX%2F1584561560.C0882799-AD01-44CB-8CF1-1A1751558752.mov?alt=media&token=1a944bef-b2b0-4037-a0ff-61a3c6f1d053")),
                  avatar: .avatar1,
                  title: "Заголовок записи 1",
                  publishDate: Date().addingTimeInterval(-.day),
                  likes: 10,
                  views: 134,
                  isLiked: false,
                  inBookmarks: false
            ),
            .init(video: VideoItem.init(image: .video2, videoUrl: URL(string: "https://firebasestorage.googleapis.com/v0/b/pitchit-f0ab2.appspot.com/o/uploads%2Fproducts%2F3MQwiMjYXy5uKBo2ZlxX%2F1584561560.C0882799-AD01-44CB-8CF1-1A1751558752.mov?alt=media&token=1a944bef-b2b0-4037-a0ff-61a3c6f1d053")),
                  avatar: .avatar2,
                  title: "Заголовок записи 2",
                  publishDate: Date().addingTimeInterval(-2 * .day),
                  likes: 3,
                  views: 210,
                  isLiked: false,
                  inBookmarks: false
            ),
            .init(video: VideoItem.init(image: .video3, videoUrl: URL(string: "https://firebasestorage.googleapis.com/v0/b/pitchit-f0ab2.appspot.com/o/uploads%2Fproducts%2F3MQwiMjYXy5uKBo2ZlxX%2F1584561560.C0882799-AD01-44CB-8CF1-1A1751558752.mov?alt=media&token=1a944bef-b2b0-4037-a0ff-61a3c6f1d053")),
                  avatar: .avatar3,
                  title: "Заголовок записи 3",
                  publishDate: Date().addingTimeInterval(-5 * .day),
                  likes: 79,
                  views: 5,
                  isLiked: false,
                  inBookmarks: false
            )
            
        ]))
    }
}
