////
////  SleepTime.swift
////  AtchI
////
////  Created by DOYEON LEE on 2023/03/28.
////
//
//import SwiftUI
//import HealthKit
//
//@available(*, deprecated, message: "데이터 추출을 위해 이전에 사용되었던 클래스입니다. 더 이상 사용되지 않습니다.")
//class HealthKitServiceTemp {
//    let healthStore = HKHealthStore()
//
//    // 읽기 및 쓰기 권한 설정
//    let read = Set([HKCategoryType.categoryType(forIdentifier: .sleepAnalysis)!])
//    let share = Set([HKCategoryType.categoryType(forIdentifier: .sleepAnalysis)!])
//
//    func configure() {
//        // 데이터 접근 가능 여부에 따라 권한 요청 메소드 호출
//        if HKHealthStore.isHealthDataAvailable() && !checkAuthorizationStatus() {
//            requestAuthorization()
//        }
//    }
//    
//    func getSleepData() {
//        // 수면 데이터 Type 정의
//        if let sleepType = HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis) {
//            // 데이터를 필터링할 조건(predicate)를 설정할 수 있음. 여기선 일주일 데이터를 받아오도록 설정
//            let calendar = Calendar.current
//            let endDate = Date() // 현재 시간
//            let startDate = calendar.date(byAdding: .day, value: -7, to: endDate) // 7일 전 시간
//            let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
//            // 최신 데이터를 먼저 가져오도록 sort 기준 정의
//            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
//            // 쿼리 수행 완료시 실행할 콜백 정의
//            let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: 50, sortDescriptors: [sortDescriptor]) { (query, tmpResult, error) -> Void in
//                if error != nil {
//                    // 에러 처리를 수행합니다.
//                    print(error)
//                    return
//                }
//                if let result = tmpResult {
//                    for item in result {
//                        if let sample = item as? HKCategorySample {
//                            // 가져온 데이터 출력
//                            print("Sleep value: \(sample.value)")
//                            print("Start Date: \(sample.startDate)")
//                            print("End Date: \(sample.endDate)")
//                            print("Metadata: \(String(describing: sample.metadata))")
//                            print("UUID: \(sample.uuid)")
//                            print("Source: \(sample.sourceRevision)")
//                            print("Device: \(String(describing: sample.device))")
//                            print("---------------------------------\n")
//                        }
//                    }
//                }
//            }
//            // HealthKit store에서 쿼리를 실행
//            healthStore.execute(query)
//        }
//    }
//}