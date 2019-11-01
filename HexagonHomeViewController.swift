//
//  HexagonHomeViewController.swift
//  Impossible Hexagon
//
//  Created by summer on 2019/7/29.
//  Copyright © 2019 summer. All rights reserved.
//

import UIKit
import FirebaseAnalytics
import UserNotifications
import StoreKit


@available(iOS 10.0, *)
class HexagonHomeViewController: UIViewController {
    
    @IBOutlet weak var highscore: UILabel!
    
    var switchNotif = true
    
    let user = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        highscore.text = "\(UserDefaults.standard.integer(forKey: "highscore"))"
        
        switchNotif = user.bool(forKey: "switch")
        if switchNotif == false {
            // ask notif and set
            notif()
            
        }
        
    }
    
    @IBAction func startGame(_ sender: Any) {
        Analytics.logEvent("start_game", parameters: nil)
    }
    
    func notif() {
        
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
                if granted {
                    print("Yay!")
                    self.scheduleNotification()
                    self.switchNotif = true
                    self.user.set(true, forKey: "switch")
                    
                } else {
                    print("D'oh")
                }
            }    
    }
    
    func scheduleNotification() {
        let center = UNUserNotificationCenter.current()
        let random = Int.random(in: 40...87)
        let content = UNMutableNotificationContent()
        content.title = "CAN YOU BEAT \(random) ??"
        content.body = "Open now and see 😎"
        content.sound = UNNotificationSound.default
        
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 12060, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          let vc = segue.destination
          vc.modalPresentationStyle = .fullScreen
      }
    
}

