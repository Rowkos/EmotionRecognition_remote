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
    static var numImagesPerEmotion: [String: Int] = ["Angry": 1, "Excited": 1, "Sad": 1, "Tired": 1]

    static func getEmotionChoices() -> [String]
    {
        while true
        {
            var choices = [String](emotionList.shuffled().prefix(4))
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
    
    static func getImageFile(emotion: String) -> String
    {
        let fm = FileManager.default
        var path = Bundle.main.resourcePath! + "/" + emotion.lowercased() + "_results"
        var items = "FAILURE TO LOAD"

        do {
            items = try fm.contentsOfDirectory(atPath: path).randomElement()!
            items = String(items.dropLast(4))
        } catch {
            // failed to read directory – bad permissions, perhaps?
        }
        return items
    }
}

