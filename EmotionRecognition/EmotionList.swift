//
//  EmotionList.swift
//  EmotionRecognition
//
//  Created by Rowan Koskoff on 8/17/23.
//

import Foundation

struct EmotionList
{
    static var emotionList: [String] = ["Angry", "Excited", "Sad", "Tired", "Surprised", "Nervous", "Annoyed", "Scared", "Confused", "Relaxed", "Interested", "Happy"]

    static func getEmotionChoices() -> [String]
    {
        while true
        {
            let choices = [String](emotionList.shuffled().prefix(4))
            if choices.contains("Happy") && choices.contains("Relaxed")
            {
                continue
            }
            if choices.contains("Surprised") && choices.contains("Confused")
            {
                continue
            }
            if choices.contains("Annoyed") && choices.contains("Angry")
            {
                continue
            }
            if choices.contains("Happy") && choices.contains("Excited")
            {
                continue
            }
            if choices.contains("Scared") && choices.contains("Nervous")
            {
                continue
            }
            return choices
        }
    }
    
    static func getImageFile(emotion: String, index: Int) -> String
    {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath! + "/" + emotion.lowercased() + "_results"
        var item = "FAILURE TO LOAD"

        do {
            let items = try fm.contentsOfDirectory(atPath: path)
            let adjustedIndex = Int(Double(items.count) * (Double(index) / 100.0))
            item = String(items[adjustedIndex].dropLast(4))
        } catch {
            // failed to read directory – bad permissions, perhaps?
        }
        return item
    }
    static func getImageFile(emotion: String) -> String
    {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath! + "/" + emotion.lowercased() + "_results"
        var items = "FAILURE TO LOAD"

        do {
            items = try fm.contentsOfDirectory(atPath: path).randomElement()!
            items = String(items.dropLast(4))
        } catch {
            // failed to read directory – bad permissions, perhaps?
        }
        return items
    }
    
    static func getSizeOfEmotion(emotion: String) -> Int
    {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath! + "/" + emotion.lowercased() + "_results"
        var items: [String] = ["FAILURE TO LOAD"]

        do {
            items = try fm.contentsOfDirectory(atPath: path)
        } catch {
            // failed to read directory – bad permissions, perhaps?
        }
        return items.count
    }
}

