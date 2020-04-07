//
//  ContentView.swift
//  WakemeGood
//
//  Created by Kishor Subedi on 4/6/20.
//  Copyright © 2020 Kishor Subedi. All rights reserved.
//

import SwiftUI

struct title: View {
    var body: some View {
        ZStack {
            Text("WakeMeGood")
                .font(.largeTitle)
                .padding(21)
                .foregroundColor(.white)
        }.background(Color.black)
        .opacity(0.8)
        .cornerRadius(10)
        .padding(15)
    }
}

struct ContentView: View {
    
    var currTime : String
    
    init() {
        self.currTime = ""
        self.currTime = findCurrTime()
    }
    
//    func isToTheRightOf(x: String) -> String {
    func findCurrTime()-> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()

        dateFormatter.dateStyle = .short

        dateFormatter.timeStyle = .short

        let dateString = dateFormatter.string(from: currentDate)
        return(dateString)
    }
    
    var body: some View {
        VStack {
            
            Text("It's " + self.currTime)
            
            Image("clock")
                   .resizable()
                   .scaledToFit()
                   .overlay(title(), alignment: .top)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

