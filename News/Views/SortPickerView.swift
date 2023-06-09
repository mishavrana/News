//
//  SortPickerView.swift
//  News
//
//  Created by Misha Vrana on 09.06.2023.
//

import SwiftUI

struct SortPickerView: View {
    @EnvironmentObject var weatherAPIResponseHandler: WeatherAPIResponseHandler
    
    @Binding var isPresented: Bool
    
    @State private var sortOption: String
    
    init(isPresented: Binding<Bool>, sortOption: String) {
        _isPresented = isPresented
        self.sortOption = sortOption
    }
    
    let sortOptionsForUser: [String] = ["relevancy", "pupularity", "newest"]
    let sortOptionsForAPI: [String] = ["relevancy", "pupularity", "publishedAt"]
    
    var body: some View {
        NavigationView {
            Form {
                Picker(
                    selection: $sortOption,
                    label: Text("Sort options: "),
                    content: {
                        ForEach(sortOptionsForUser.indices, id: \.self) { index in
                            Text(sortOptionsForUser[index])
                                .tag(sortOptionsForAPI[index])
                        }
                }).pickerStyle(MenuPickerStyle())
            }
            .navigationBarTitle("Filter news")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: cancel, trailing: done)
        }
    }
    
    var cancel: some View {
        Button("Cancel") {
            self.isPresented = false
        }
    }
    
    var done: some View {
        Button("Done") {
            self.isPresented = false
            weatherAPIResponseHandler.setSortOptions(sortOption)
        }
    }
    
}

//struct SortPickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        SortPickerView(isPresented: .constant(true))
//            .environmentObject(WeatherAPIResponseHandler())
//    }
//}
