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

struct alarmTime: View {
    @State private var hour: String = ""
    @State private var minute: String = ""
    
    func setAlarm(){
        
    }
    
    var body: some View {
        HStack {
            Text("Alarm Time: ")
                .font(.title)
                .padding(5)
                .foregroundColor(.blue)
            
            TextField("Hour", text: $hour).frame(width: 60, height: 60)
            Text(":")
            TextField("Minute", text: $minute).frame(width: 60, height: 60)
            
            Button(action: setAlarm) {
                Text("Set")
            }.frame(width: 60, height: 60)
        }
        .opacity(0.7)
        .cornerRadius(10)
        .padding(5)
    }
}

struct ContentView: View {
    
    var alarmSpacing = 35
    
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
            
            Text("It's " + self.currTime).font(.title)
            
            Image("clock")
                   .resizable()
                   .scaledToFit()
                   .overlay(title(), alignment: .top)
                   .overlay(alarmTime(), alignment: .bottomLeading)
            
            Text("Remember! A pre-alarm is going to wake you up " + String(alarmSpacing) + " minutes (default) before the actual alarm.").font(.headline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

