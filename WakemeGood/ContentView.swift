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

class Model {
    var preAlarmHour: String
    var preAlarmMinute: String
    init(){
        preAlarmHour = ""
        preAlarmMinute = ""
    }
    func setPreAlarmTime(hour: String, minute: String, alarmsSpacing: Int){
              let intHour = Int(hour)
              let intMinute = Int(minute)
              
              if(intMinute! >= alarmsSpacing){
                   preAlarmHour = hour
                   preAlarmMinute = String(intMinute! - alarmsSpacing)
              }
              else{
                   preAlarmMinute = String(60 - (alarmsSpacing - intMinute!))
                   preAlarmHour = String(intHour! - 1)
              }
    }
}

struct alarmTime: View {
    @State private var hour: String = ""
    @State private var minute: String = ""
    @State private var alarmsSpacing: Int = 30
    @State var sleepQuality: String = "";
    
    @State var preAlarmToggle = true
    @State var alarmToggle = true
    
    @State private var alarmSet: Bool = false
    
    var model = Model()
    
    init(alarmsSpacing: Int){
        self.alarmsSpacing = alarmsSpacing
    }
    
    func setAlarm(){
        if (self.hour != "" && self.minute != "")
        {
            self.alarmSet = true
            model.setPreAlarmTime(hour: self.hour, minute: self.minute, alarmsSpacing: alarmsSpacing)
        }
    }
    
    func cancelAlarm(){
        self.alarmSet = false
    }
    
    func spaceOutAlarms(){
        alarmsSpacing += 10
        alarmSet = false
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
                 Text("Remember! A pre-alarm is going off 35 minutes before this time in the hope that you'd wake you up during light sleep mode for a refreshing wake! ")
            }
            else{
                
                VStack {
                    HStack{
                            Text("Pre Alarm At:      ")
                            
                            Toggle(isOn: $preAlarmToggle) {
                                Text("\t" + model.preAlarmHour + ":" + model.preAlarmMinute)
                            }.disabled(true)
                        }
                    
                    HStack{
                        Text("Actual Alarm At: ")
                        
                        Toggle(isOn: $alarmToggle) {
                            Text("\t" + self.hour + ":" + self.minute)
                        }.disabled(true)
                    }
                    
                   // Image().resizable().scaledToFit()
                    
                    HStack {
                        
                        Text("Rate your waking experience").bold()
                        
                        Image("Screen Shot 2020-04-08 at 2.16.24 AM").resizable().frame(width: 150.0, height: 42.0).scaledToFit()

                    }
                    
                    Text("If you felt extra drowsy on both the alarms And sleep affecting factors like coffee/wine/excessive workout weren't the cause, Proceed to click the button below: ").lineLimit(4).frame(width: 400, height: 100, alignment: .center)
                    
                    Button(action: spaceOutAlarms) {
                   Text("Increase your alarms spacing time by 10 minutes")
                   }.background(Color.red).opacity(0.95)
                   .foregroundColor(.white)
                                               
                }
                
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
            title()
            
            Text("It's " + self.currTime).font(.title)
            
            Image("clock").resizable().frame(width: 300, height: 230, alignment: .center).scaledToFit().padding()
            
            alarmTime(alarmsSpacing: 30)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

