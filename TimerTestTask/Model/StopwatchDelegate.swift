//
//  StopwatchDelegate.swift
//  TimerTestTask
//
//  Created by Sasha Myshkina on 10.02.2020.
//  Copyright © 2020 Sasha Myshkina. All rights reserved.
//

import Foundation

protocol StopwatchDelegate: class {
    
    func show(time t: Int) -> Void
    
}
