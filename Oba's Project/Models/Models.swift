//
//  Models.swift
//  OsagieProject
//
//  Created by Ibukunoluwa Soyebo on 01/08/2021.
//

import Foundation

//enum FieldNameEnum:String{
//    case field1 = "Temperature (K)"
//    case field2 = "Humidity (g.m-3)"
//    case field3 = "Soil Moisture (%)"
//    case field4 = "Methane"
//}

class ThingSpeakField {
    internal init(fieldTitle: String = "", field_value_array: [ThingSpeakFieldValues] = []) {
        self.fieldTitle = fieldTitle
        self.field_value_array = field_value_array
    }
    var fieldTitle = ""
    var field_value_array:[ThingSpeakFieldValues] = []
}


struct ThingSpeakFieldValues{
    var value:Int = 0
    var wholeDate = Date()
    var actualDate = Date()
    var actualTime = Date()
//    var date = Date()
}


class AdaFruitResult {
    
    internal init(current: Double, date_stamp: String, id: Int, power: Double, time_stamp: String, voltage: Double, iOSDate: Date, iOSTime: Date, cumulativePower: Double = 0, kiloWattHour: Double = 0) {
        self.current = current
        self.date_stamp = date_stamp
        self.id = id
        self.power = power
        self.time_stamp = time_stamp
        self.voltage = voltage
        self.iOSDate = iOSDate
        self.iOSTime = iOSTime
        self.cumulativePower = cumulativePower
        self.kiloWattHour = kiloWattHour
    }
   
    
    var current:Double
    var date_stamp:String
    var id:Int
    var power:Double
    var time_stamp:String
    var voltage:Double
    var iOSDate:Date
    var iOSTime:Date
    var cumulativePower:Double = 0
    var kiloWattHour:Double = 0
    
    
}
