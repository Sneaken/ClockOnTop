//
//  AppTheme.swift
//  ClockOnTop
//

import SwiftUI

struct AppTheme: Identifiable, Equatable {
    let id: String
    let name: String
    let textColor: Color
    let backgroundColor: Color

    static let allThemes: [AppTheme] = [
        AppTheme(
            id: "default",
            name: "默认",
            textColor: Color(red: 0.922, green: 0.184, blue: 0.588, opacity: 0.8),
            backgroundColor: Color(red: 0.96, green: 0.94, blue: 0.92, opacity: 0.15)
        ),
        AppTheme(
            id: "dark",
            name: "深色",
            textColor: Color.white.opacity(0.9),
            backgroundColor: Color.black.opacity(0.45)
        ),
        AppTheme(
            id: "neon",
            name: "霓虹",
            textColor: Color(red: 0.0, green: 1.0, blue: 0.5, opacity: 0.9),
            backgroundColor: Color(red: 0.02, green: 0.02, blue: 0.02, opacity: 0.5)
        ),
        AppTheme(
            id: "amber",
            name: "琥珀",
            textColor: Color(red: 1.0, green: 0.8, blue: 0.0, opacity: 0.9),
            backgroundColor: Color(red: 0.08, green: 0.04, blue: 0.0, opacity: 0.5)
        ),
        AppTheme(
            id: "ice",
            name: "冰蓝",
            textColor: Color(red: 0.5, green: 0.9, blue: 1.0, opacity: 0.95),
            backgroundColor: Color(red: 0.02, green: 0.02, blue: 0.04, opacity: 0.5)
        ),
        AppTheme(
            id: "coral",
            name: "珊瑚",
            textColor: Color(red: 1.0, green: 0.5, blue: 0.4, opacity: 0.9),
            backgroundColor: Color(red: 0.08, green: 0.02, blue: 0.02, opacity: 0.5)
        ),
        AppTheme(
            id: "lavender",
            name: "薰衣草",
            textColor: Color(red: 0.95, green: 0.65, blue: 1.0, opacity: 0.95),
            backgroundColor: Color(red: 0.04, green: 0.02, blue: 0.05, opacity: 0.5)
        ),
        AppTheme(
            id: "mint",
            name: "薄荷",
            textColor: Color(red: 0.5, green: 1.0, blue: 0.75, opacity: 0.9),
            backgroundColor: Color(red: 0.02, green: 0.06, blue: 0.03, opacity: 0.5)
        ),
        AppTheme(
            id: "sunset",
            name: "日落",
            textColor: Color(red: 1.0, green: 0.55, blue: 0.15, opacity: 0.9),
            backgroundColor: Color(red: 0.08, green: 0.03, blue: 0.01, opacity: 0.5)
        ),
        AppTheme(
            id: "sakura",
            name: "樱花",
            textColor: Color(red: 1.0, green: 0.75, blue: 0.9, opacity: 0.95),
            backgroundColor: Color(red: 0.06, green: 0.02, blue: 0.03, opacity: 0.5)
        ),
        AppTheme(
            id: "ocean",
            name: "海洋",
            textColor: Color(red: 0.4, green: 0.8, blue: 1.0, opacity: 0.95),
            backgroundColor: Color(red: 0.02, green: 0.03, blue: 0.05, opacity: 0.5)
        ),
        AppTheme(
            id: "lemon",
            name: "柠檬",
            textColor: Color(red: 1.0, green: 0.95, blue: 0.3, opacity: 0.9),
            backgroundColor: Color(red: 0.06, green: 0.05, blue: 0.0, opacity: 0.5)
        ),
        AppTheme(
            id: "rose-gold",
            name: "玫瑰金",
            textColor: Color(red: 1.0, green: 0.7, blue: 0.6, opacity: 0.9),
            backgroundColor: Color(red: 0.08, green: 0.03, blue: 0.02, opacity: 0.5)
        ),
        AppTheme(
            id: "silver",
            name: "银灰",
            textColor: Color(red: 0.85, green: 0.9, blue: 0.95, opacity: 0.9),
            backgroundColor: Color(red: 0.04, green: 0.04, blue: 0.05, opacity: 0.5)
        ),
        AppTheme(
            id: "violet",
            name: "紫罗兰",
            textColor: Color(red: 0.85, green: 0.45, blue: 1.0, opacity: 0.95),
            backgroundColor: Color(red: 0.03, green: 0.01, blue: 0.04, opacity: 0.5)
        ),
        AppTheme(
            id: "emerald",
            name: "翡翠",
            textColor: Color(red: 0.35, green: 1.0, blue: 0.65, opacity: 0.9),
            backgroundColor: Color(red: 0.02, green: 0.06, blue: 0.03, opacity: 0.5)
        ),
        AppTheme(
            id: "sky",
            name: "天蓝",
            textColor: Color(red: 0.6, green: 0.85, blue: 1.0, opacity: 0.95),
            backgroundColor: Color(red: 0.02, green: 0.02, blue: 0.04, opacity: 0.5)
        ),
        AppTheme(
            id: "peach",
            name: "桃色",
            textColor: Color(red: 1.0, green: 0.75, blue: 0.65, opacity: 0.9),
            backgroundColor: Color(red: 0.08, green: 0.03, blue: 0.02, opacity: 0.5)
        ),
        AppTheme(
            id: "wine",
            name: "酒红",
            textColor: Color(red: 1.0, green: 0.25, blue: 0.4, opacity: 0.9),
            backgroundColor: Color(red: 0.06, green: 0.01, blue: 0.02, opacity: 0.5)
        ),
        AppTheme(
            id: "cobalt",
            name: "钴蓝",
            textColor: Color(red: 0.4, green: 0.65, blue: 1.0, opacity: 0.95),
            backgroundColor: Color(red: 0.02, green: 0.02, blue: 0.04, opacity: 0.5)
        ),
        AppTheme(
            id: "crimson",
            name: "猩红",
            textColor: Color(red: 1.0, green: 0.15, blue: 0.25, opacity: 0.9),
            backgroundColor: Color(red: 0.06, green: 0.01, blue: 0.01, opacity: 0.5)
        ),
        AppTheme(
            id: "gold",
            name: "鎏金",
            textColor: Color(red: 1.0, green: 0.88, blue: 0.25, opacity: 0.9),
            backgroundColor: Color(red: 0.06, green: 0.04, blue: 0.0, opacity: 0.5)
        ),
        AppTheme(
            id: "plum",
            name: "梅紫",
            textColor: Color(red: 0.95, green: 0.45, blue: 0.8, opacity: 0.95),
            backgroundColor: Color(red: 0.04, green: 0.01, blue: 0.03, opacity: 0.5)
        ),
        AppTheme(
            id: "teal",
            name: "青绿",
            textColor: Color(red: 0.25, green: 0.95, blue: 0.9, opacity: 0.9),
            backgroundColor: Color(red: 0.02, green: 0.06, blue: 0.05, opacity: 0.5)
        ),
    ]

    static func theme(withId id: String) -> AppTheme {
        allThemes.first { $0.id == id } ?? allThemes[0]
    }
}
