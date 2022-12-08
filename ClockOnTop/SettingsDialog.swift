//
//  SettingsDialog.swift
//  ClockOnTop
//
//  Created by Sneaken on 2022/12/7.
//
import SwiftUI

struct SettingsDialog: View {
    @EnvironmentObject var settings: UserSettings
    @State private var fontFamily: String = ""
    @State private var color: String = ""

    var body: some View {
        VStack {
            TextField("字体", text: $fontFamily)
            TextField("颜色", text: $color)
            Button("保存") {
                settings.fontFamily = self.fontFamily
            }
        }
        .padding(20)
        .frame(width: 150, height: 150)
        .onAppear {
            self.fontFamily = settings.fontFamily
            self.color = settings.color
        }
    }
}
