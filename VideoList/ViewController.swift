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
    var topVideos = [VideoObject]()

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
        let request = VideoListRequest(part: [.id, .statistics], filter: .chart, maxResults: 20)
        
        // Send a request.
        ApiSession.shared.send(request) { result in
            switch result {
            case .success(let response):
                print(response.items)
                self.YTVideos = response.items
                
                for video in response.items {
                    if let dislikes = Int((video.statistics?.dislikeCount)!) {
                        if let likes = Int((video.statistics?.likeCount)!) {
                            let tempVideo = VideoObject()
                            
                            tempVideo.title = video.contentDetails?.caption ?? "Title"
                            tempVideo.rating = likes / dislikes
                            tempVideo.url = "https://www.youtube.com/watch?v=" + video.id
                            if tempVideo.rating > 80 {
                                self.topVideos.append(tempVideo)
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
//        cell.textLabel?.text = topVideos[indexPath.row].title
        cell.titleTextField.text = topVideos[indexPath.row].title
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
}

