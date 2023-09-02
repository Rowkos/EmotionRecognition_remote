//
//  Level2.swift
//  EmotionRecognition
//
//  Created by Rowan Koskoff on 8/17/23.
//

import SwiftUI

struct Level3: View {
    var emotions = EmotionList.emotionList
    @State var emotionChoices = EmotionList.getEmotionChoices()
    @State var targetEmotionIndex = Int.random(in: 0..<4)
    @State var score = 0
    let maxScore = 20.0
    @State var showInstructions = false
    
    var body: some View {
        VStack{
            Image("D&D Campaign")
            ProgressView(value: Double(score) / maxScore)
                .tint(.green)
                .scaleEffect(x: 1, y: 2)
                .padding([.top, .leading, .trailing], 20)
            
            Text(String(Int(score)) + "/" + String(Int(maxScore)))
            ZStack(alignment: .topTrailing){
                Text(emotionChoices[targetEmotionIndex]).font(.largeTitle).multilineTextAlignment(.center).padding(.horizontal, 100)
                Button(action: promptQuestion)
                {
                    ZStack{
                        Ellipse()
                            .frame(width: 47, height: 47)
                            .foregroundColor(.black)
                        Ellipse()
                            .frame(width: 43, height: 43)
                            .foregroundColor(.gray)
                        Text("?")
                            .foregroundColor(.black)
                            .scaleEffect(2)
                    }
                }.alert("Choose the picture the best represents how the main character in the scenario is feeling", isPresented: $showInstructions)
                {
                    Button("OK")
                    {
                        showInstructions.toggle()
                    }
                }
            }
            ZStack{
                Color(.systemGray4).ignoresSafeArea()
                ScrollView
                {
                    optionButton(i: 0)
                    optionButton(i: 1)
                    optionButton(i: 2)
                    optionButton(i: 3)
                }
            }
        }
    }
    func optionButton(i: Int) -> some View
    {
        func buttonClicked()
        {
            if i == targetEmotionIndex
            {
                score += 1
                emotionChoices = EmotionList.getEmotionChoices()
                targetEmotionIndex = Int.random(in: 0..<4)
            }
        }
        let randomImageIndex = Int.random(in: 0..<EmotionList.numImagesPerEmotion[emotionChoices[i]]!)
        let imageId = emotionChoices[i].lowercased() + "_" + String(randomImageIndex)
        
        return Button(action: buttonClicked)
        {
            Image(imageId).resizable().cornerRadius(20).scaledToFit().padding(20)
        }
    }
    func promptQuestion()
    {
        showInstructions.toggle()
    }
}

struct Level3_Previews: PreviewProvider {
    static var previews: some View {
        Level3()
    }
}
