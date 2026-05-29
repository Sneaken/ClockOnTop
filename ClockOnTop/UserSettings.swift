//
//  UserSettings.swift
//  ClockOnTop
//
//  Created by Sneaken on 2022/12/7.
//

import SwiftUI

final class UserSettings: ObservableObject {
    @AppStorage("font_family") var fontFamily: String = "Cascadia Mono"
}
