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

struct beforeAlarm: View {
    var body: some View {
        Text("Remember! A pre-alarm is going off 35 minutes before this time in the hope that you'd wake you up during light sleep mode for a refreshing wake! '")
    }
}

struct afterAlarm: View {
    var body: some View {
        VStack{
            Text("Alarms On! You should feel refreshing waking up to one of the two alarms. If not, report and We'll tune your spacing times.")
            Text("Stop Alarm")
        }

    }
}


struct alarmTime: View {
    @State private var hour: String = ""
    @State private var minute: String = ""
    
    @State private var alarmSet: Bool = false
    
    func setAlarm(){
        if (self.hour != "" && self.minute != "")
        {
            self.alarmSet = true
        }
    }
    
    var body: some View {
        VStack {
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
            if (alarmSet == false){
                 beforeAlarm()
            }
            else{
                afterAlarm()
            }
               
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
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

