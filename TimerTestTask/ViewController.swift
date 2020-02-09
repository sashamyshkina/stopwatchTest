//
//  ViewController.swift
//  TimerTestTask
//
//  Created by Sasha Myshkina on 07.02.2020.
//  Copyright © 2020 Sasha Myshkina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let cellSpacingHeight: CGFloat = 20
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timerList: UITableView!
    
    var timeCount = 0
    var timer = Timer()
    var laps: [Int] = []
    
    let defaults = UserDefaults.standard
    var timeStarted: Date?
    var timeEnded: Date?
    var timeSpent: TimeInterval = 0.0
    
    var alert = UIAlertController()
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    override func viewDidLoad() {

        timerList.delegate = self
        timerList.dataSource = self
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(onceTapped))
        singleTap.numberOfTapsRequired = 1
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(singleTap)
        view.addGestureRecognizer(tap)
        
        alert = UIAlertController(title: "New lap!", message: "Do you want to save it to your list?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Save", style: .default) { alert in
            self.laps.append(Int(self.timeCount))
            self.timeCount = 0
            self.timeStarted = nil
            self.timeLabel.text = NSString(format: "%02d:%02d:%02d", self.timeCount/3600,(self.timeCount/60)%60,self.timeCount%60) as String
            self.timerList.reloadData()
        })
            
        alert.addAction(UIAlertAction(title: "Don't save", style: .cancel) { alert in
            self.timeCount = 0
            self.timeStarted = nil
            self.timeLabel.text = NSString(format: "%02d:%02d:%02d", self.timeCount/3600,(self.timeCount/60)%60,self.timeCount%60) as String
        })
        
        timerList.register(UINib(nibName: "LapCell", bundle: nil), forCellReuseIdentifier: "LapCell")

        
    }
    
    @objc private func timeDidFire() {
        timeCount += 1
        timeLabel.text = NSString(format: "%02d:%02d:%02d", timeCount/3600,(timeCount/60)%60,timeCount%60) as String
    }
    
    @objc func doubleTapped() {
        timeEnded = Date()
        timer.invalidate()
        self.present(alert, animated: true)
    }
    
    @objc func onceTapped() {
        //start and resume
        if !timer.isValid {
            timeStarted = Date()
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timeDidFire), userInfo: nil, repeats: true)
        } else {
        //pause
            timeEnded = Date()
            timer.invalidate()
            timeSpent += (timeEnded! - timeStarted!).rounded(.down)
            
        }
    }
    
    
    @IBAction func infoPressed(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "InfoViewController") as! InfoViewController
        
        self.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return laps.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        let cell = timerList.dequeueReusableCell(withIdentifier: "LapCell", for: indexPath) as! LapCell
        
        let totalTime = laps[indexPath.section]
        cell.timingLabel.text = NSString(format: "%02d:%02d:%02d", totalTime/3600,(totalTime/60)%60,totalTime%60) as String
        cell.numberLabel.text = String(indexPath.section + 1)
        return cell
    }
    
    
    
}

