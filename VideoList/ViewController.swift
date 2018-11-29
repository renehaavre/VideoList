//
//  ViewController.swift
//  VideoList
//
//  Created by Rene Haavre on 29/11/2018.
//  Copyright © 2018 Rene Haavre. All rights reserved.
//

import UIKit
import YoutubeKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    var YTVideos = [Video]()
    var topVideos = [Video]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        makeRequest {
            self.tableView.reloadData()
        }
    }
    
    func makeRequest(completionHandler: @escaping () -> Void) {
        
        // Create list video request
        let request = VideoListRequest(part: [.id, .statistics], filter: .chart, maxResults: 50)
        
        // Send a request.
        ApiSession.shared.send(request) { result in
            switch result {
            case .success(let response):
                print(response.items)
                self.YTVideos = response.items
                
                for video in response.items {
                    if let dislikes = Int((video.statistics?.dislikeCount)!) {
                        if let likes = Int((video.statistics?.likeCount)!) {
                            let likeRatio = likes / dislikes
                            print("https://www.youtube.com/watch?v=" + video.id)
                            print("Ratio: ", likeRatio)
                            if likeRatio > 80 {
                                self.topVideos.append(video)
                            }
                        }
                    }
                }
                completionHandler()
            case .failed(let error):
                print(error)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topVideos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! VideoTableViewCell
        cell.textLabel?.text = topVideos[indexPath.row].id
        
        return cell
    }


}

