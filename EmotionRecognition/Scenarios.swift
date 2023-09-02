//
//  Scenarios.swift
//  EmotionRecognition
//
//  Created by Rowan Koskoff on 8/27/23.
//

import Foundation

struct Scenarios
{
    static func getScenario(file: String) -> String{
        var text = "ERROR, NO DATA READ"
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let fileURL = dir.appendingPathComponent(file)
            do {
                text = try String(contentsOf: fileURL, encoding: .utf8)
            }
            catch {/* error handling here */}
        }
        return text
    }
}
