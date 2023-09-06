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
    @State var questionsAnswered = 0
    let maxScore = 20.0
    @State var showInstructions = false
    @State var showCorrect = false
    @State var showIncorrect = false
    @State var showCompletionScreen = false
    @State var selectedImage = ""
    @State var imageIndices: [Int] = [Int.random(in: 0..<100), Int.random(in: 0..<100), Int.random(in: 0..<100), Int.random(in: 0..<100)]
    @State var scenarioIndex = Int.random(in: 0..<100)

    var body: some View {
        if showCorrect == false && showIncorrect == false && showCompletionScreen == false
        {
            ZStack{
                Color(.systemGray4).ignoresSafeArea()
                VStack{
                    ProgressView(value: Double(score) / maxScore)
                        .tint(.green)
                        .scaleEffect(x: 1, y: 2)
                        .padding([.top, .leading, .trailing], 20)
                    
                    Text(String(Int(score)) + "/" + String(Int(maxScore)))
                    ZStack(alignment: .topTrailing){
                        ScrollView
                        {
                            Text(Scenarios.getScenario(file: emotionChoices[targetEmotionIndex], index: scenarioIndex)).font(.title).multilineTextAlignment(.leading).padding(.horizontal, 30)
                        }
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
                        }.padding(20).alert("Choose the picture the best represents the scenario", isPresented: $showInstructions)
                        {
                            Button("OK")
                            {
                                showInstructions.toggle()
                            }
                        }
                    }
                    HStack
                    {
                        answerButton(i: 0)
                        Spacer()
                        answerButton(i: 1)
                    }
                    .padding(.all, 20.0)
                    HStack
                    {
                        answerButton(i: 2)
                        Spacer()
                        answerButton(i: 3)
                    }
                    .padding(.all, 20.0)
                }
            }
        }
        if showCorrect
        {
            ZStack (alignment: .topTrailing){
                Image("CorrectPopup").resizable().transition(.slide)
                Button("Done")
                {
                    showCorrect = false
                    emotionChoices = EmotionList.getEmotionChoices()
                    targetEmotionIndex = Int.random(in: 0..<4)
                }.transition(.opacity)
                    .padding(20)
            }
        }
        if showIncorrect
        {
            ZStack (alignment: .topTrailing){
                VStack{
                    Spacer()
                    Image("IncorrectPopup").resizable().scaledToFit()
                    Spacer()
                    Text("The correct answer was: ")
                        .font(.title)
                    Text(emotionChoices[targetEmotionIndex]).font(.largeTitle)
                    Text(Scenarios.getExplanation(file: emotionChoices[targetEmotionIndex], index: scenarioIndex)).font(.title3).padding(15)
                    Spacer()
                }.transition(.slide)
                Button("Done")
                {
                    showIncorrect = false
                    emotionChoices = EmotionList.getEmotionChoices()
                    targetEmotionIndex = Int.random(in: 0..<4)
                }.padding(20).transition(.opacity)
            }
        }
        if showCompletionScreen && showCorrect == false
        {
            ZStack{
                Color(.systemGray4).ignoresSafeArea()
                VStack{
                    Text("Well Done!").font(.largeTitle).multilineTextAlignment(.center)
                    Text("You completed level 1 with an accuracy of: ").font(.title).multilineTextAlignment(.center)
                    Text(String(Int(score)) + "/" + String(questionsAnswered)).font(.largeTitle).foregroundColor(Color.orange).scaleEffect(1.2).padding(20)
                    HStack{
                        Image(systemName: "star.fill")
                        if Double(score) / Double(questionsAnswered) > 0.8
                        {
                            Image(systemName: "star.fill")
                        }
                        else
                        {
                            Image(systemName: "star")
                        }
                        if Double(score) / Double(questionsAnswered) > 0.9
                        {
                            Image(systemName: "star.fill")
                        }
                        else
                        {
                            Image(systemName: "star")
                        }
                    }.scaleEffect(1.5).foregroundColor(.orange)
                    Image("MainMenuElephant").resizable().rotationEffect(Angle(degrees: -90.0)).padding(.horizontal, 50).scaledToFit()
                }.transition(.slide)
            }
        }
    }
    func answerButton(i: Int) -> some View{
        func buttonClicked()
        {
            
            if i == targetEmotionIndex
            {
                showCorrect = true
                score += 1
            }
            else
            {
                showIncorrect = true
            }
            if score == Int(maxScore)
            {
                UserDefaults.standard.set(1, forKey: DefaultsKeys.keys[2])
                if Double(score) / Double(questionsAnswered) > 0.8
                {
                    UserDefaults.standard.set(2, forKey: DefaultsKeys.keys[2])
                }
                if Double(score) / Double(questionsAnswered) > 0.9
                {
                    UserDefaults.standard.set(3, forKey: DefaultsKeys.keys[2])
                }
                showCompletionScreen = true
            }
            questionsAnswered += 1
        }
        return Button(action: buttonClicked)
        {
            ZStack{
                Rectangle().frame(width: 100.0, height: 50.0).foregroundColor(.brown).cornerRadius(10.0).shadow(radius: 15)
                Text(emotionChoices[i])
            }
            
        }
        .frame(width: 75.0)
        .foregroundColor(.black)
        .padding(.all, 20.0)
    }
    func optionButton(i: Int) -> some View
    {
        let imageId = EmotionList.getImageFile(emotion: emotionChoices[i], index: imageIndices[i])
        func buttonClicked()
        {
            if i == targetEmotionIndex
            {
                score += 1
                showCorrect = true
            }
            else
            {
                showIncorrect = true
            }
            if score == Int(maxScore)
            {
                showCompletionScreen = true
                UserDefaults.standard.set(1, forKey: DefaultsKeys.keys[1])
                if Double(score) / Double(questionsAnswered) > 0.8
                {
                    UserDefaults.standard.set(2, forKey: DefaultsKeys.keys[1])
                }
                if Double(score) / Double(questionsAnswered) > 0.9
                {
                    UserDefaults.standard.set(3, forKey: DefaultsKeys.keys[1])
                }
            }
            questionsAnswered += 1
        }
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
