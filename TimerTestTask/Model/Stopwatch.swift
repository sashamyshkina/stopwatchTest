//
//  Stopwatch.swift
//  TimerTestTask
//
//  Created by Sasha Myshkina on 09.02.2020.
//  Copyright © 2020 Sasha Myshkina. All rights reserved.
//

import Foundation


class Stopwatch {
    
    var defaults = UserDefaults.standard
    
    var momentStarted: Date?
    var momentStopped: Date?
        
    var timer = Timer()
    
    var isRunning: Bool {
        return defaults.double(forKey: "momentStarted") != -1
    }
        
    var delegate: StopwatchDelegate?
    
    func pause() {
        defaults.set(self.time, forKey: "timeCount")
        defaults.set(-1, forKey: "momentStarted")
        timer.invalidate()
    }
    
    func start() {
        
        let interval = defaults.double(forKey: "momentStarted")
        
        momentStarted = isRunning ? Date(timeIntervalSince1970: interval) : Date()
        
        defaults.set(momentStarted! - Date(timeIntervalSince1970: 0), forKey: "momentStarted")
        
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(timeDidFire), userInfo: nil, repeats: true)
    }
    
    func stop() -> Int {
        
        let time = self.time
        
        defaults.set(0, forKey: "timeCount")
        defaults.set(-1, forKey: "momentStarted")
        
        timer.invalidate()
        
        return time
    }
    
    @objc func timeDidFire() {
        delegate?.show(time: self.time)
    }
    
    func prepare() {
        if self.isRunning {
            timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(timeDidFire), userInfo: nil, repeats: true)
        }
        
        self.delegate?.show(time: self.time)
    }
    
    var time: Int {
        var time = defaults.double(forKey: "timeCount")
        let interval = defaults.double(forKey: "momentStarted")
        if (interval != -1) {
            momentStarted = Date(timeIntervalSince1970: interval)
            time += (Date() - momentStarted!)
        }
        
        return Int(time)
    }
}
