//
//  DateExtension.swift
//  TimerTestTask
//
//  Created by Sasha Myshkina on 08.02.2020.
//  Copyright © 2020 Sasha Myshkina. All rights reserved.
//

import Foundation

extension Date {

    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }

}
