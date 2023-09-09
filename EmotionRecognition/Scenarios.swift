//
//  Scenarios.swift
//  EmotionRecognition
//
//  Created by Rowan Koskoff on 8/27/23.
//

import Foundation

struct Scenarios
{
    static func getScenario(file: String, index: Int) -> String{
        let path = Bundle.main.resourcePath! + "/EmotionScenariosGPT4 2/" + file.lowercased()
         
        var returnString = ""
        do {
            let data = try String(contentsOfFile: path)
            var rows = data.components(separatedBy: "\n")
            let adjustedIndex = Int(Double(rows.count) * (Double(index) / 100.0))
            rows.removeFirst()
            var subString = rows[index]
            let range = subString.index(subString.startIndex, offsetBy: 3)..<subString.index(subString.endIndex, offsetBy: -2)
            subString = String(subString[range])
            let splitString = subString.components(separatedBy: "\",")[0]
            let finalRange = splitString.index(splitString.startIndex, offsetBy: 1)..<splitString.index(splitString.endIndex, offsetBy: -1)
            let finalSplitString = " " + splitString[finalRange] + "."
            returnString = String(finalSplitString).replacingOccurrences(of: "..", with: ".").replacingOccurrences(of: "  ", with: " ").replacingOccurrences(of: "\"\"", with: "\"")
            
        } catch {
            print(error)
            return returnString
        }
        return returnString
    }
    
    static func getExplanation(file: String, index: Int) -> String{
        let path = Bundle.main.resourcePath! + "/EmotionScenariosGPT4 2/" + file.lowercased()

        var returnString = ""
        do {
            var data = try String(contentsOfFile: path)
            var rows = data.components(separatedBy: "\n")
            rows.removeFirst()
            var subString = rows[index]
            let range = subString.index(subString.startIndex, offsetBy: 3)..<subString.index(subString.endIndex, offsetBy: -2)
            subString = String(subString[range])
            var splitString = " " + String(subString.components(separatedBy: "\",\"")[1]) + "."
            returnString = splitString.replacingOccurrences(of: ". .", with: ".").replacingOccurrences(of: "  ", with: " ").replacingOccurrences(of: "..", with: ".").replacingOccurrences(of: "\"\"", with: "\"")
            
        } catch {
            print(error)
            return returnString
        }
        return returnString
    }
}
