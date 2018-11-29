//
//  ViewController.swift
//  VideoList
//
//  Created by Rene Haavre on 29/11/2018.
//  Copyright © 2018 Rene Haavre. All rights reserved.
//

import UIKit
import YoutubeKit

class ViewController: UIViewController {
    
    var YTVideos = [Video]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Create list video request
        let request = VideoListRequest(part: [.id, .statistics], filter: .chart, maxResults: 50)
        
        DispatchQueue.main.async {
            // Send a request.
            ApiSession.shared.send(request) { result in
                switch result {
                case .success(let response):
                    print(response.items)
                    self.YTVideos = response.items
                    
                    for video in response.items{
                        if let dislikes = Int((video.statistics?.dislikeCount)!) {
                            if let likes = Int((video.statistics?.likeCount)!) {
                                let likeRatio = likes / dislikes
                                print("https://www.youtube.com/watch?v=" + video.id)
                                print("Ratio: ", likeRatio)
                            }
                        }
                    }
                case .failed(let error):
                    print(error)
                }
            }
        }
        
    }


}

