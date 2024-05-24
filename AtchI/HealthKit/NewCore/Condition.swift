//
//  SleepCondition.swift
//  AtchI
//
//  Created by DOYEON LEE on 5/22/24.
//

import Foundation

enum SampleCondition: Condition {
    case isWatch
    case isPhone
    case notContain(_ samples: [SampleEntity])
    case sameMinute(baseDate: Date)
    
    func isSatisfy(_ sample: SampleEntity) -> Bool {
        switch self {
        case .isWatch:
            return sample.dateSourceProductType == .watch
        case .isPhone:
            return sample.dateSourceProductType == .iPhone
        case let .notContain(samples):
            return !samples.contains(sample)
        case let .sameMinute(baseDate):
            let calendar = Calendar.current
            let baseDateComponents = calendar.dateComponents([.day, .hour, .minute], from: baseDate)
            let targetDateComponents = calendar.dateComponents([.day, .hour, .minute], from: sample.startDate)

            return targetDateComponents == baseDateComponents
        }
    }
}

protocol Condition {
    func isSatisfy(_ sample: SampleEntity) -> Bool
}

class IsWatchCondition: Condition {
    func isSatisfy(_ sample: SampleEntity) -> Bool {
        return sample.dateSourceProductType == .watch
    }
}

class IsPhoneCondition: Condition {
    func isSatisfy(_ sample: SampleEntity) -> Bool {
        return sample.dateSourceProductType == .iPhone
    }
}

class SleepTypeCondition: Condition {
    private let sleepType: HKSleepType
    
    init(_ sleepType: HKSleepType){
        self.sleepType = sleepType
    }
    
    func isSatisfy(_ sample: SampleEntity) -> Bool {
        let sleepSample = sample as! SleepEntity
        return sleepSample.sleepType == self.sleepType
    }
}

class NotContainCondition: Condition {
    private let samples: [SampleEntity]
    
    init(_ samples: [SampleEntity]) {
        self.samples = samples
    }
    
    func isSatisfy(_ sample: SampleEntity) -> Bool {
        return !samples.contains(sample)
    }
}

class SameMinuteCondition: Condition {
    private let date: Date
    
    init(_ date: Date) {
        self.date = date
    }
    
    func isSatisfy(_ sample: SampleEntity) -> Bool {
        let calendar = Calendar.current
        let targetDateComponents = calendar.dateComponents([.day, .hour, .minute], from: date)
        let dateComponents = calendar.dateComponents([.day, .hour, .minute], from: sample.startDate)

        return dateComponents == targetDateComponents
    }
}

