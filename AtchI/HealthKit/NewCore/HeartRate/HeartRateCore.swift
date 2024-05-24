//
//  HeartRateCore.swift
//  AtchI
//
//  Created by DOYEON LEE on 5/22/24.
//

import Foundation

class HeartRateCore {
    func getHeartRateBPM(_ samples: [HeartRateEntity])
    -> [Double] {
        let heartRateByMinute: [[HeartRateEntity]] = GroupingFilter(
            samples: samples,
            conditions: [
                SameMinuteCondition(sample.startDate)
            ]
        )
        
        return heartRateByMinute
            .map { HeartRateCalculator($0).calculateAverage() }
    }
    
    private func groupByMinute(
        _ samples: [HeartRateEntity]
    ) -> [[HeartRateEntity]] {
        return samples
            .sorted { $0.startDate < $1.startDate }
            .reduce(into: [[HeartRateEntity]]()) { (result, sample) in
                guard let lastGroup = result.last else {
                    result.append([sample])
                    return
                }

                let filtered = SampleFilter(
                    conditions: [
                        NotContainCondition(lastGroup),
                        SameMinuteCondition(sample.startDate)
                    ]
                ).filter(samples)
                    .map { $0 as! HeartRateEntity }
                
                result.append(filtered)
            }
    }
    
    
//        var totalArray: [Double] = []
//        var minuteArray: [Double] = []
//    
//        for idx in 0..<samples.count { // 모든 샘플에 대해서
//            let dateComponent = Calendar.current.dateComponents([.hour, .minute], from: samples[idx].startDate)
//            let heartRate = round(samples[idx].quantity)
//    
//            for hour in 0...23 { // 24시간 검증
//                if idx == 0 {
//                    minuteArray.append(heartRate) // 첫번째는 비교대상이 없음
//                } else {
//                    let beforeDatecomponent = Calendar.current.dateComponents([.hour, .minute], from: samples[idx-1].startDate) // 이전 샘플의 시작 시간
//                    if dateComponent.hour == hour { // 만약 같은 시간대면
//                        if beforeDatecomponent.minute == dateComponent.minute { // 분도 같으면
//                            minuteArray.append(heartRate) // 평균으로 처리하기 위해 append
//                        } else if dateComponent.minute != beforeDatecomponent.minute { // 분이 다르면 다음 분으로 넘어 온 것
//                            if minuteArray.isEmpty != true { // 아예 없는 시간대는 패스
//                                let minuteAver = Double(minuteArray.reduce(0,+))/Double(minuteArray.count) // 평균 계산
//                                totalArray.append(minuteAver) // 전체에 추가
//                                minuteArray.removeAll()
//                            }
//                            minuteArray.append(heartRate)
//    //                                    print("시간 배열 \(hourArray)")
//                            if idx == samples.count-1 && minuteArray.isEmpty != true { // 마지막 요소이면 여기까지 정리해야하므로
//                                let minuteAver = Double(minuteArray.reduce(0,+))/Double(minuteArray.count) // 똑같이 평균 계산
//                                totalArray.append(minuteAver)
//                                minuteArray.removeAll()
//                            }
//                        }
//                    } else { // 시간이 다르면 분이 다름이 보장
//                        continue // 계속 진행
//                    }
//                }
//            }
//    
//        }
//        return totalArray
}
