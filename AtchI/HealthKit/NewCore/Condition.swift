//
//  SleepCondition.swift
//  AtchI
//
//  Created by DOYEON LEE on 5/22/24.
//

import Foundation


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

class SameTimeCondition: Condition {
    private let date: Date
    private let components: [Calendar.Component]
    
    init(_ date: Date, components: [Calendar.Component]) {
        self.date = date
        self.components = components
    }
    
    func isSatisfy(_ sample: SampleEntity) -> Bool {
        let calendar = Calendar.current
        let targetDateComponents = calendar.dateComponents(Set(components), from: date)
        let dateComponents = calendar.dateComponents(Set(components), from: sample.startDate)

        return dateComponents == targetDateComponents
    }
}

//class SameTimeCondition: Condition {
//    private let components: [Calendar.Component]
//    
//    init(components: [Calendar.Component], baseDate: SampleEntity) {
//        self.components = components
//        self.baseSample = baseDate
//    }
//    
//    func isSatisfy(_ sample: SampleEntity) -> Bool {
//        let calendar = Calendar.current
//        let targetDateComponents = calendar.dateComponents(Set(components), from: sample.startDate)
//        let dateComponents = calendar.dateComponents(Set(components), from: baseSample.startDate)
//
//        return dateComponents == targetDateComponents
//    }
//}
//
