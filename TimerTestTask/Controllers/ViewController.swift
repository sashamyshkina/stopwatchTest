//
//  ViewController.swift
//  TimerTestTask
//
//  Created by Sasha Myshkina on 07.02.2020.
//  Copyright © 2020 Sasha Myshkina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let stopwatch: Stopwatch = Stopwatch()
    
    let cellSpacingHeight: CGFloat = 20
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timerList: UITableView!
    
    var laps: [Int] = []
    
    let defaults = UserDefaults.standard
    var alert = UIAlertController()
    var time = 0

    override func viewDidLoad() {
        
        laps = (defaults.array(forKey: "laps") as? [Int]) ?? []

        timerList.delegate = self
        timerList.dataSource = self

        addGestureRecognizers()
        configureAlerts()
    
        timerList.register(UINib(nibName: "LapCell", bundle: nil), forCellReuseIdentifier: "LapCell")

        stopwatch.delegate = self
        stopwatch.prepare(setupDefaults: laps.isEmpty)
    }
    
    
    @objc func doubleTapped() {
        self.time = self.stopwatch.stop()
        self.present(alert, animated: true)
    }
    
    @objc func onceTapped() {
        
        if !stopwatch.isRunning {
            stopwatch.start()
        } else {
            stopwatch.pause()
        }
    }
    
    @IBAction func infoPressed(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "InfoViewController") as! InfoVC
        self.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    private func addGestureRecognizers() {
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(onceTapped))
        singleTap.numberOfTapsRequired = 1
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        doubleTap.numberOfTapsRequired = 2
        view.addGestureRecognizer(singleTap)
        view.addGestureRecognizer(doubleTap)
    }
    
    private func configureAlerts() {
        alert = UIAlertController(title: "New lap!", message: "Do you want to save it to your list?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Save", style: .default) { alert in
            self.laps.insert(self.time, at: 0)
            self.clearTime()
            self.timerList.reloadData()
            self.defaults.set(self.laps, forKey: "laps")
        })
        
        alert.addAction(UIAlertAction(title: "Don't save", style: .cancel) { alert in
            self.clearTime()
        })
    }
    
    private func clearTime() {
        self.time = 0
        self.timeLabel.text = self.time.stopWatchString()
    }
}


extension ViewController: StopwatchDelegate {
    func show(time: Int) {
        timeLabel.text = time.stopWatchString()
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
        cell.timingLabel.text = totalTime.stopWatchString()
        cell.numberLabel.text = String(indexPath.section + 1)
        
        return cell
    }
}

