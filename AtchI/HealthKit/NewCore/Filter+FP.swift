//
//  Filter+FP.swift
//  AtchI
//
//  Created by DOYEON LEE on 5/24/24.
//

import Foundation

extension Array where Element: SampleEntity {
    func filter(with conditions: [SampleCondition]) -> [Element] {
        return self.filter { sample in
            conditions.allSatisfy { condition in
                condition.isSatisfy(sample)
            }
        }
    }
}



extension Array where Element: SampleEntity {
    func filter(with preConditions: [Condition], alternativeConditions: [Condition]) -> [Element] {
        let preConditionSatisfy = self.filter { sample in
            preConditions.allSatisfy { condition in
                condition.isSatisfy(sample)
            }
        }
        if preConditionSatisfy.isEmpty {
            return self.filter { sample in
                alternativeConditions.allSatisfy { condition in
                    condition.isSatisfy(sample)
                }
            }
        } else {
            return preConditionSatisfy
        }
    }
}
