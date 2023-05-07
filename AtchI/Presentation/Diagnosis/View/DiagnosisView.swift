//
//  DiagnosisView.swift
//  AtchI
//
//  Created by 강민규 on 2023/03/21.
//

import SwiftUI

import Moya

struct DiagnosisView: View {
    let watchInfoViewModel = WatchInfoViewModel()
    let selfTestViewModel = SelfTestViewModel(service: DiagnosisService(provider: MoyaProvider<DiagnosisAPI>()))
    
    @State private var path: [DiagnosisViewStack] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("진단")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 18)
                    
                    SelfTestInfoView(
                        selfTestViewModel: selfTestViewModel,
                        path: $path)
                    
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 20)
                
                Rectangle()
                    .frame(height: 15)
                    .foregroundColor(.grayBoldLine)
                
                WatchInfoView(viewModel: watchInfoViewModel)
                    .padding(.all, 30)
                
                Spacer()
            }
        }
        .onAppear {
            //MARK: 서버 데이터 들고오기
            selfTestViewModel.getData()
        }
    }
}

struct DiagnosisView_Previews: PreviewProvider {
    static var previews: some View {
        DiagnosisView()
    }
}
