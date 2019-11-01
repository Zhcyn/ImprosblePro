//
//  HexagonGameOverViewController.swift
//  Impossible Hexagon
//
//  Created by summer on 2019/7/29.
//  Copyright © 2019 summer. All rights reserved.
//

import UIKit
import FirebaseAnalytics
import SCSDKCreativeKit
import StoreKit

class HexagonGameOverViewController: UIViewController {
    
    @IBOutlet weak var current: UILabel!
    @IBOutlet weak var highscore: UILabel!
    
    var snapAPI: SCSDKSnapAPI?
    
    let defaults = UserDefaults.standard
    
    var currentS = 0
    var highscoreS = 0
    
    var countPlay = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentS = defaults.integer(forKey: "score")
        highscoreS = defaults.integer(forKey: "highscore")
        
        current.text = "\(currentS)"
        highscore.text = "\(highscoreS)"
        
        snapAPI = SCSDKSnapAPI()
        
        countPlay = UserDefaults.standard.integer(forKey: "played")
        countPlay += 1
        
        if countPlay >= 7 {
            if #available( iOS 10.3,*){
                SKStoreReviewController.requestReview()
            }
        }
        
    }
    
    
    @IBAction func sharePressed(_ sender: Any) {
        Analytics.logEvent("share_snap", parameters: nil)
        
        shareScore { (success, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            }
            
        }
    }
    
    
    func shareScore(completionHandler: (Bool, Error?) ->()) {
        let message = "Check out this app!! "
        let url = "http://itunes.apple.com/app/id" + "1475403000"
        if let link = NSURL(string: url)
        {
            let objectsToShare = [message,link] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            if let popoverController = activityVC.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: self.view.bounds.width, height: 0)
                popoverController.permittedArrowDirections = []
            }
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func returnPressed(_ sender: Any) {
        Analytics.logEvent("restart", parameters: nil)
    }
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          let vc = segue.destination
          vc.modalPresentationStyle = .fullScreen
      }
    
}
