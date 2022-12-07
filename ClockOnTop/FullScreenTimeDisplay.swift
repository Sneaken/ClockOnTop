//
//  FullScreenTimeDisplay.swift
//  ClockOnTop
//
//  Created by Sneaken on 2022/12/7.
//

import SwiftUI

struct FullScreenTimeDisplay: View {
    @State private var currentTime: String = ""

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                ZStack {
                    Text(currentTime)
                        .foregroundColor(.indigo)
                        .font(.custom("Cascadia Mono", size: min(max(geometry.size.height * 0.8, 8), max(geometry.size.width * 0.2, 8))))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .onAppear(perform: startTimer)
                }
                .edgesIgnoringSafeArea(.all)
            }
        }

        .frame(minWidth: 180, minHeight: 50)
    }

    private func startTimer() {
        // 创建一个定时器，每隔一秒更新当前时间
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.currentTime = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .medium)
        }
    }
}

struct FullScreenTimeDisplay_Previews: PreviewProvider {
    static var previews: some View {
        FullScreenTimeDisplay()
    }
}
