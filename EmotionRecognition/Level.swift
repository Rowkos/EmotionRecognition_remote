//
//  ContentView.swift
//  EmotionRecognition
//
//  Created by Rowan Koskoff on 8/2/23.
//

import SwiftUI

struct CorrectView: View
{
    var body: some View
    {
        Image("CorrectPopup").resizable()
    }
}
struct IncorrectView: View
{
    var body: some View
    {
        Image("IncorrectPopup").resizable()
    }
}

struct Level: View {
    let emotions = EmotionList.emotionList
    @State var emotionChoices = EmotionList.getEmotionChoices()
    @State var targetEmotionIndex = Int.random(in: 0..<4)
    @State var score = 0.0
    // replace with random choice
    @State var correct_button = 2
    @State var showInstructions = false
    @State var showCorrect = false
    @State var showIncorrect = false
    var popoverAnchor = Rectangle()
    var max_score = 20.0
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        var randomImageIndex = Int.random(in: 0..<EmotionList.numImagesPerEmotion[emotionChoices[targetEmotionIndex]]!)
        if showCorrect == false && showIncorrect == false
        {
            ZStack {
                Color(.systemGray4).ignoresSafeArea()
                VStack {
                    ProgressView(value: score / max_score)
                        .tint(.green)
                        .scaleEffect(x: 1, y: 2)
                    
                    Text(String(Int(score)) + "/" + String(Int(max_score)))
                    ZStack (alignment: .topTrailing){
                        Image(emotionChoices[targetEmotionIndex].lowercased() + "_" + String(randomImageIndex))
                            .resizable()
                            .frame(width: 380.0, height: 380.0)
                            .cornerRadius(20.0)
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                            .shadow(radius: 15)
                        Button(action: promptQuestion)
                        {
                            ZStack{
                                Ellipse()
                                    .frame(width: 47, height: 47)
                                    .foregroundColor(.black)
                                Ellipse()
                                    .frame(width: 43, height: 43)
                                    .foregroundColor(.brown)
                                Text("?")
                                    .foregroundColor(.black)
                                    .scaleEffect(2)
                            }
                        }
                        .padding(20)
                        .alert("Choose the emotion word that is best represented by the facial expression displayed", isPresented: $showInstructions)
                        {
                            Button("OK")
                            {
                                showInstructions.toggle()
                            }
                        }
                        .frame(width: 100, height: 100)
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
                .padding()
                
            }
        }
        if showCorrect
        {
            ZStack (alignment: .topTrailing){
                CorrectView().transition(.slide)
                Button("Done")
                {
                    showCorrect = false
                }.transition(.opacity)
                    .padding(20)
            }
        }
        if showIncorrect
        {
            ZStack (alignment: .topTrailing){
                IncorrectView().transition(.slide)
                Button("Done")
                {
                    showIncorrect = false
                }.transition(.opacity)
                    .padding(20)
            }
        }
    }
    func answerButton(i: Int) -> some View{
        func buttonClicked()
        {
            if i == targetEmotionIndex
            {
                score += 1
                emotionChoices = EmotionList.getEmotionChoices()
                targetEmotionIndex = Int.random(in: 0..<4)
            }
            if score == max_score
            {
                UserDefaults.standard.set(1, forKey: DefaultsKeys.keys[0])
            }
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

    
    func promptQuestion()
    {
        showInstructions.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Level()
    }
}
