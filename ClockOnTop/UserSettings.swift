//
//  UserSettings.swift
//  ClockOnTop
//
//  Created by Sneaken on 2022/12/7.
//
import SwiftUI

class UserSettings: ObservableObject {
    @Published var fontFamily: String = UserDefaults.standard.string(forKey: "font_family") ?? "Cascadia Mono" {
        willSet {
            UserDefaults.standard.set(newValue, forKey: "font_family")
            self.objectWillChange.send()
        }
    }

    @Published var color: String = UserDefaults.standard.string(forKey: "color") ?? "" {
        willSet {
            UserDefaults.standard.set(newValue, forKey: "color")
            self.objectWillChange.send()
        }
    }
}
