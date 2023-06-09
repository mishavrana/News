//
//  DatePickerView.swift
//  News
//
//  Created by Misha Vrana on 09.06.2023.
//

import SwiftUI

struct DatePickerView: View {
    @EnvironmentObject var weatherAPIResponseHandler: WeatherAPIResponseHandler
    
    @State private var fromDate = Date()
    @State private var toDate = Date()
    
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                DatePicker("From: ", selection: $fromDate, displayedComponents: [.date])
                DatePicker("To: ", selection: $toDate, displayedComponents: [.date])
            }
            .navigationTitle("Choose date interval: ")
            .navigationBarItems(leading: cancel, trailing: done)
        }
    }
    var cancel: some View {
        Button("Cancel") {
            self.isPresented = false
            weatherAPIResponseHandler.setDateBounds(fromDate: nil, toDate: nil)
        }
    }
    
    var done: some View {
        Button("Done") {
            self.isPresented = false
            weatherAPIResponseHandler.setDateBounds(fromDate: fromDate, toDate: toDate)
            weatherAPIResponseHandler.getArticles()
            
        }
    }

}


//struct DatePickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        DatePickerView(isPresented: .constant(true))
//    }
//}
