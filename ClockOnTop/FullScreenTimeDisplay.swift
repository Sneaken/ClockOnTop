//
//  FullScreenTimeDisplay.swift
//  ClockOnTop
//
//  Created by Sneaken on 2022/12/7.
//

import SwiftUI

struct FullScreenTimeDisplay: View {
    @EnvironmentObject var settings: UserSettings
    @State private var currentTime: String = ""
    @State private var isShowingInputDialog = false

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                ZStack {
                    Text(currentTime)
                        .foregroundColor(Color(red: 0.25, green: 0.52, blue: 0.58, opacity: 0.8))
                        .font(.custom(settings.fontFamily, size: min(max(geometry.size.height * 0.8, 8), max(geometry.size.width * 0.2, 8))))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)

                        .onAppear(perform: startTimer)
                        .contextMenu {
                            Button("设置") {
                                self.isShowingInputDialog = true
                            }
                        }
                }
                .edgesIgnoringSafeArea(.all)
            }
        }
        .popover(isPresented: $isShowingInputDialog) {
            SettingsDialog().environmentObject(settings)
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
