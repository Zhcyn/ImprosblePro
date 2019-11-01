//
//  HexagonPlayViewController.swift
//  Impossible Hexagon
//
//  Created by summer on 2019/7/29.
//  Copyright © 2019 summer. All rights reserved.
//
import UIKit
//import GoogleMobileAds

class HexagonPlayViewController: UIViewController {
    
    
    // outlet
    @IBOutlet weak var scoreLblOutlet: UILabel!
    
    @IBOutlet weak var imgOutlet: UIImageView!
    @IBOutlet weak var recgtangleOutlet: UIImageView!
    
    
    var timer: Timer?
    
    
    // 0,1,2,3
    var squareFace = 0
    
    var score = 0
    
    var changer = 10
    
    //
    var recgColor = 0
    
    var numLevel = 17
    
    let Defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLblOutlet.text = "0"
        
        setUpSquare()
        
        if timer == nil {
            let timer = Timer(timeInterval: 0.1,
                              target: self,
                              selector: #selector(updateTimer),
                              userInfo: nil,
                              repeats: true)
            RunLoop.current.add(timer, forMode: .common)
            timer.tolerance = 0.1
            
            self.timer = timer
        }
        view.addSubview(imgOutlet)
        view.addSubview(scoreLblOutlet)
        
        
    }
    
    @objc func updateTimer() {
        
        
        
        
        scoreLblOutlet.text = "\(Int(score))"
        
        changer += numLevel
        
        recgtangleOutlet.frame = CGRect(x: view.frame.maxX - (30 + CGFloat(integerLiteral: changer)), y: 0, width: 120, height: self.view.frame.height)
        
        let viewX = view.frame.maxX
        if  Int(viewX) + 130 <  changer {
            score += 1
            recgColor = Int.random(in: 0...3)
            changer = 0
            numLevel += 2
            if numLevel > 35 {
                numLevel = 35
            }
            setUpReg()
            recgtangleOutlet.frame = CGRect(x: view.frame.maxX - (30 + CGFloat(integerLiteral: changer)), y: 0, width: 120, height: self.view.frame.height)
        }
        
        // finish
        
        let first = Int(imgOutlet.frame.maxX)
        let second = Int(recgtangleOutlet.frame.minX)
        print(first)
        print(second)
        print(recgtangleOutlet.frame.minX)
        
        if first >= second && recgColor != squareFace && first - 95 <= second {
            
            
            print("testy")
            timer?.invalidate()
            
            // save score
            
            Defaults.set(Int(score), forKey: "score")
            
            if Int(score) > Defaults.integer(forKey: "highscore") {
                Defaults.set(Int(score), forKey: "highscore")
            }
            
            performSegue(withIdentifier: "goShare", sender: self)
            
            
            
            
            
        }
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if squareFace < 5 {
            squareFace += 1
            setUpSquare()
        } else {
            squareFace = 0
            setUpSquare()
        }
        
    }
    
    
    func setUpSquare() {
        if squareFace == 0 {
            imgOutlet.image = #imageLiteral(resourceName: "HexagonYellow")
        } else if squareFace == 1 {
            imgOutlet.image = #imageLiteral(resourceName: "HexagonRed")
        } else if squareFace == 2 {
            imgOutlet.image = #imageLiteral(resourceName: "Hexagon")
        } else if squareFace == 3 {
            imgOutlet.image = #imageLiteral(resourceName: "HexagonGreen")
        } else if squareFace == 4 {
            imgOutlet.image = #imageLiteral(resourceName: "HexagonPilple")
        } else if squareFace == 5 {
            imgOutlet.image = #imageLiteral(resourceName: "HexagonZong")
        }
    }
    
    func setUpReg() {
        if recgColor == 0 {
            recgtangleOutlet.image = #imageLiteral(resourceName: "yellow")
        } else if recgColor == 1 {
            recgtangleOutlet.image = #imageLiteral(resourceName: "red")
        } else if recgColor == 2 {
            recgtangleOutlet.image = #imageLiteral(resourceName: "blue")
        } else if recgColor == 3 {
            recgtangleOutlet.image = #imageLiteral(resourceName: "Rectangle")
        } else if recgColor == 4 {
            recgtangleOutlet.image = #imageLiteral(resourceName: "pilple")
        } else if recgColor == 5 {
            recgtangleOutlet.image = #imageLiteral(resourceName: "Image")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination
        vc.modalPresentationStyle = .fullScreen
    }
    
    
    
}
