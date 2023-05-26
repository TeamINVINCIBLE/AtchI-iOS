//
//  WatchActivityView.swift
//  AtchI
//
//  Created by DOYEON LEE on 2023/05/21.
//

import Foundation
import SwiftUI

struct WatchActivityView: View {
    
    @Binding var stepCount: String
    @Binding var heartAverage: String
    @Binding var sleepTotal: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text("👟 걸음수")
                    .font(.bodyMedium)
                Spacer()
                if stepCount.count == 0 {
                    LottieView(lottieFile: "dots-loading",
                               loopMode: .loop)
                    .frame(width: 70,
                           height: 20)
                } else {
                    Text("\(stepCount)")
                        .font(.bodyMedium)
                }
            }
            HStack {
                Text("❤️ 심박평균")
                    .font(.bodyMedium)
                Spacer()
                if heartAverage.count == 0 {
                    LottieView(lottieFile: "dots-loading",
                               loopMode: .loop)
                    .frame(width: 70,
                           height: 20)
                } else {
                    Text("\(heartAverage)")
                        .font(.bodyMedium)
                }
            }
            HStack {
                Text("💤 수면시간")
                    .font(.bodyMedium)
                Spacer()
                if sleepTotal.count == 0 {
                    LottieView(lottieFile: "dots-loading",
                               loopMode: .loop)
                    .frame(width: 70,
                           height: 20)
                } else {
                    Text("\(sleepTotal)")
                        .font(.bodyMedium)
                }
            }
        }
    }
}


struct WatchActivityView_Previews: PreviewProvider {
    static var previews: some View {
        WatchActivityView(stepCount: .constant(""), heartAverage: .constant(""), sleepTotal: .constant(""))
    }
}
