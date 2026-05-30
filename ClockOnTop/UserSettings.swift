//
//  UserSettings.swift
//  ClockOnTop
//
//  Created by Sneaken on 2022/12/7.
//

import SwiftUI

final class UserSettings: ObservableObject {
    @Published var fontFamily: String = {
        let stored = UserDefaults.standard.string(forKey: "font_family")
        return (stored?.isEmpty == false) ? stored! : "Cascadia Mono"
    }() {
        didSet { UserDefaults.standard.set(fontFamily, forKey: "font_family") }
    }

    @Published var themeId: String = {
        let stored = UserDefaults.standard.string(forKey: "theme_id")
        return (stored?.isEmpty == false) ? stored! : "default"
    }() {
        didSet { UserDefaults.standard.set(themeId, forKey: "theme_id") }
    }

    var currentTheme: AppTheme {
        AppTheme.theme(withId: themeId)
    }
}
