//
//  SampleEntity.swift
//  AtchI
//
//  Created by DOYEON LEE on 5/22/24.
//

import Foundation

class SampleEntity: Equatable {
    let id: UUID
    let startDate: Date
    let endDate: Date
    let dateSourceProductType: HKProductType
    
    init(startDate: Date, endDate: Date, dateSourceProductType: HKProductType) {
        self.id = UUID()
        self.startDate = startDate
        self.endDate = endDate
        self.dateSourceProductType = dateSourceProductType
    }
    
    static func ==(rhs: SampleEntity, lhs: SampleEntity) -> Bool {
        return rhs.id == lhs.id
    }
}
