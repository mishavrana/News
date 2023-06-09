//
//  NewsApp.swift
//  News
//
//  Created by Misha Vrana on 08.06.2023.
//

import SwiftUI

@main
struct NewsApp: App {
    @StateObject var weatherAPIResponseHandler = WeatherAPIResponseHandler()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(weatherAPIResponseHandler)
        }
    }
}
