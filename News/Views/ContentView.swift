//
//  ContentView.swift
//  News
//
//  Created by Misha Vrana on 08.06.2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var weatherResponseAPIHandler: WeatherAPIResponseHandler
    
    var body: some View {
        NewsView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
