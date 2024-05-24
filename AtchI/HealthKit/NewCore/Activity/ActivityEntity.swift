//
//  ActivityEntity.swift
//  AtchI
//
//  Created by DOYEON LEE on 5/23/24.
//

import Foundation

enum ActivityType {
    case step
    case energy
    case distance
}

class ActivityEntity: SampleEntity {
    let activityType: ActivityType
    let quantity: Double
    
    init(
        startDate: Date,
        endDate: Date,
        dateSourceProductType: HKProductType,
        activityType: ActivityType,
        quantity: Double
    ) {
        self.activityType = activityType
        self.quantity = quantity
        super.init(startDate: startDate, endDate: endDate, dateSourceProductType: dateSourceProductType)
    }
}
