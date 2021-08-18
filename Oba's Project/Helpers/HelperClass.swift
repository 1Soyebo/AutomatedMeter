//
//  HelperClass.swift
//  OsagieProject
//
//  Created by Ibukunoluwa Soyebo on 02/08/2021.
//

import Foundation
import Charts

class HelperClass{
    static var globalAdaFruit = [AdaFruitResult]()
}

public class DateValueFormatter: NSObject, IAxisValueFormatter {
    private let dateFormatter = DateFormatter()
    private let objects:[AdaFruitResult]
    
    init(objects: [AdaFruitResult]) {
        self.objects = objects
        super.init()
        dateFormatter.dateFormat = "HH:mm"
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        if value >= 0 && value < Double(objects.count){
            let object = objects[Int(value)]
            return dateFormatter.string(from: object.iOSTime)
        }
        return ""
    }
}


extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}


extension Date{
    func toShortString() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        return dateFormatter.string(from: self)
    }
    
    func toTimeShortStrin() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        return dateFormatter.string(from: self)
    }
    
    func toDateShortString() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: self)
    }
}
