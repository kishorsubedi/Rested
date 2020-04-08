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
        Text("Remember! A pre-alarm is going off 35 minutes before this time in the hope that you'd wake you up during light sleep mode for a refreshing wake! ")
    }
}

struct afterAlarm: View {
    @State var preAlarmOn = true
    @State var actualAlarmOn = true
    
    var disableToggle = true
    
    var hour: String
    var minute: String
    
    var preAlarmHour: String = ""
    var preAlarmMinute: String = ""
    
    
    init(hour:String, minute:String, alarmsSpacing: Int){
        self.hour = hour
        self.minute = minute
        setPreAlarmTime(hour:hour, minute:minute, alarmsSpacing: alarmsSpacing)
    }
    
    mutating func setPreAlarmTime(hour: String, minute: String, alarmsSpacing: Int){
        let intHour = Int(hour)
        let intMinute = Int(minute)
        
        if(intMinute! >= 30){
            preAlarmHour = hour
            preAlarmMinute = String(intMinute!-alarmsSpacing)
        }
        else{
            preAlarmMinute = String(60 - (30 - intMinute!))
            preAlarmHour = String(intHour! - 1)
        }
    }

    var body: some View {
        VStack {
            HStack{
                    Text("Pre Alarm At:      ")
                    
                    Toggle(isOn: $preAlarmOn) {
                        Text("\t" + preAlarmHour + ":" + preAlarmMinute)
                    }.disabled(disableToggle)
                }
            
                HStack{
                    Text("Actual Alarm At: ")
                    
                    Toggle(isOn: $actualAlarmOn) {
                        Text("\t" + self.hour + ":" + self.minute)
                    }.disabled(disableToggle)
                }
        }
            
    }
}

struct alarmTime: View {
    @State private var hour: String = ""
    @State private var minute: String = ""
    
    @State private var alarmSet: Bool = false
    var alarmsSpacing = 30
    
    func setAlarm(){
        if (self.hour != "" && self.minute != "")
        {
            self.alarmSet = true
        }
    }
    
    func cancelAlarm(){
        self.alarmSet = false
    }
    
    var body: some View {
        VStack {
           
            if (alarmSet == false){
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
            }
            else{
                HStack {
                    Text("Alarms Set!")
                                        .font(.title)
                                        .padding(5)
                                        .foregroundColor(.blue)
                    Spacer()
                    
                    Button(action: cancelAlarm) {
                        Text("Reset Alarms")
                        }.background(Color.red).opacity(0.9)
                        .foregroundColor(.white)
                }
            }
                
            
            if (alarmSet == false){
                 beforeAlarm()
            }
            else{
                afterAlarm(hour: self.hour, minute: self.minute, alarmsSpacing: alarmsSpacing)
            }
               
        }

        .opacity(0.7)
        .cornerRadius(10)
        .padding(5)
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

