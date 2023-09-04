//
//  EmotionList.swift
//  EmotionRecognition
//
//  Created by Rowan Koskoff on 8/17/23.
//

import Foundation

struct EmotionList
{
    static var emotionList: [String] = ["Angry", "Excited", "Sad", "Tired", "Surprised", "Nervous", "Annoyed", "Scared", "Confused", "Relaxed", "Disappointed", "Interested", "Happy"]
    static var numImagesPerEmotion: [String: Int] = ["Angry": 1, "Excited": 1, "Sad": 1, "Tired": 1]

    static func getEmotionChoices() -> [String]
    {
        return [String](emotionList.shuffled().prefix(4))
        
    }
}
