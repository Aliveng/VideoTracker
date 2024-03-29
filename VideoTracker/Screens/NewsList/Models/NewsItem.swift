//
//  NewsItem.swift
//  VideoTracker
//
//  Created by Кирилл Худяков on 18.07.2020.
//  Copyright © 2020 Татьяна Севостьянова. All rights reserved.
//

import UIKit


struct NewsItem {
    var video: VideoItem
    var avatar: UIImage
    var title: String
    var publishDate: Date
    var likes: Int
    var views: Int
    var isLiked: Bool
    var inBookmarks: Bool
}
