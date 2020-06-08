//
//  Logger.swift
//  110DigitalLabs
//
//  Created by Venkat Krovi on 1/12/20.
//  Copyright © 2018 110DigitalLabs. All rights reserved.
//

import Foundation

/// Logging system
/// Usage Logger.error("") / Logger.info("") / Logger.debug("") / Logger.warning("")
/// Log example:
/// 12-03-2018 09:59:22998 [🛑][AppDelegate.swift] line=> 42 function=> application(_:didFinishLaunchingWithOptions:) -> Test error
/// 12-03-2018 09:59:23147 [ℹ️][AppDelegate.swift] line=> 43 function=> application(_:didFinishLaunchingWithOptions:) -> Test info
/// 12-03-2018 09:59:23148 [⚠️][AppDelegate.swift] line=> 44 function=> application(_:didFinishLaunchingWithOptions:) -> Test warning
/// 12-03-2018 09:59:23148 [💬][AppDelegate.swift] line=> 45 function=> application(_:didFinishLaunchingWithOptions:) -> Test debug
/// It automatically takes the class name, line at class, function name and print the object
public struct Logger {
    enum LogEvent: String {
        case error = "[🛑]" // error
        case info = "[ℹ️]" // info
        case debug = "[💬]" // debug
        case warning = "[⚠️]" // warning
    }
    
    static var dateFormat = "MM-dd-yyyy hh:mm:ssSSS"
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    private static func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
    
    static public func error( _ object: Any, filename: String = #file, line: Int = #line, funcName: String = #function) {
        #if DEBUG
         printWithLines("\(dateFormatter.string(from: Date())) \(LogEvent.error.rawValue)[\(sourceFileName(filePath: filename))] line=> \(line) function=> \(funcName) -> \(object)")
        #endif
    }
    
    static public func info( _ object: Any, filename: String = #file, line: Int = #line, funcName: String = #function) {
        #if DEBUG
        printWithLines("\(dateFormatter.string(from: Date())) \(LogEvent.info.rawValue)[\(sourceFileName(filePath: filename))] line=> \(line) function=> \(funcName) -> \(object)")
        #endif
    }
    
    static public func debug( _ object: Any, filename: String = #file, line: Int = #line, funcName: String = #function) {
        #if DEBUG
        printWithLines("\(dateFormatter.string(from: Date())) \(LogEvent.debug.rawValue)[\(sourceFileName(filePath: filename))] line=> \(line) function=> \(funcName) -> \(object)")
        #endif
    }
    static public func warning( _ object: Any, filename: String = #file, line: Int = #line, funcName: String = #function) {
        #if DEBUG
        printWithLines("\(dateFormatter.string(from: Date())) \(LogEvent.warning.rawValue)[\(sourceFileName(filePath: filename))] line=> \(line) function=> \(funcName) -> \(object)")
        #endif
    }

    private static func printWithLines(_ string: String) {
        var message:String = ""
        message += "\n"
        message += string
        message += "\n"
        print(message)
    }
}
