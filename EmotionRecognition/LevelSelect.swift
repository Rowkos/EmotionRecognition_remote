//
//  LevelSelect.swift
//  EmotionRecognition
//
//  Created by Rowan Koskoff on 8/12/23.
//

import SwiftUI

let screenRect = UIScreen.main.bounds
let screenWidth = screenRect.size.width
let screenHeight = screenRect.size.height
let moveFactor = 130.0
let connectorFactor = 70.0

struct DefaultsKeys {
    static let keys: [String] = ["level1Stars", "level2Stars", "level3Stars", "level4Stars", "level5Stars"]
}

struct LevelSelect: View {
    @State var showLevel = 0
    let defaults = UserDefaults.standard
    var body: some View {
        if showLevel != 0{
            ZStack (alignment: .topLeading){
                if showLevel == 1
                {
                    Level()
                }
                if showLevel == 2
                {
                    Level2()
                }
                if showLevel == 3
                {
                    Level3()
                }
                Button(action: returnToLevelSelect)
                {
                    HStack(spacing: 1){
                        Image(systemName: "arrowshape.left").scaleEffect(0.8)
                        Text("Back")
                    }
                }.padding(15).padding(.vertical, 15)
            }
        }
        else
        {
            ZStack
            {
                Color(.systemGray4).ignoresSafeArea()
                ScrollView{
                    ZStack{
                        Text("Click on a level to begin. Once you have gotten an accuracy of 20/30 or better, you will got your first star and can move on to the next level.").font(.title2).multilineTextAlignment(.center).padding(.horizontal, 60).padding(.vertical, 20)
                        Image("LevelConnectorCropped").resizable().scaleEffect(1.3).frame(width: 160, height: 160).position(x: screenWidth / 2, y:screenHeight / 2 - connectorFactor - moveFactor)
                        Image("LevelConnectorMirrored").resizable().scaleEffect(1.3).frame(width: 160, height: 160).position(x: screenWidth / 2, y: screenHeight / 2 - connectorFactor)
                        Image("LevelConnectorCropped").resizable().scaleEffect(1.3).frame(width: 160, height: 160).position(x: screenWidth / 2, y:screenHeight / 2 + connectorFactor)
                        Image("LevelConnectorMirrored").resizable().scaleEffect(1.3).frame(width: 160, height: 160).position(x: screenWidth / 2, y:screenHeight / 2 + connectorFactor + moveFactor)
                        levelIcon(i: 1).position(x: screenWidth / 2 - 100, y: screenHeight / 2 - moveFactor - moveFactor)
                        levelIcon(i: 2).position(x: screenWidth / 2 + 100, y: screenHeight / 2 - moveFactor)
                        levelIcon(i: 3).position(x: screenWidth / 2 - 100, y: screenHeight / 2)
                        levelIcon(i: 4).position(x: screenWidth / 2 + 100, y: screenHeight / 2 + moveFactor)
                        levelIcon(i: 5).position(x: screenWidth / 2 - 100, y: screenHeight / 2 + moveFactor + moveFactor)
                    }.scaleEffect(1.2)
                }
            }
        }
    }
    func explanationPopup()
    {
        
    }
    func returnToLevelSelect()
    {
        showLevel = 0
    }
    func getStarState(level: Int, star: Int) -> some View
    {

        let num = defaults.integer(
            forKey: DefaultsKeys.keys[level - 1]
        )
        if num >= star
        {
            return Image(systemName: "star.fill")
        }
        else
        {
            return Image(systemName: "star")
        }
    }
    func levelIcon(i: Int) -> some View{
        func openLevel1()
        {
            showLevel = i
        }
        return VStack{
            ZStack
            {
                Ellipse()
                    .frame(width: 65, height: 65)
                    .foregroundColor(.white)
                Button(action: openLevel1){
                    ZStack{
                        Ellipse()
                            .frame(width: 65, height: 65)
                            .foregroundColor(.gray)
                        Text(String(i))
                    }
                    
                }
                .foregroundColor(.white)
                
            }
            HStack (spacing: 0){
                getStarState(level: i, star: 1)
                getStarState(level: i, star: 2)
                getStarState(level: i, star: 3)
            }
        }
        .padding(20)
        .padding(.horizontal, 60)
    }
}

struct LevelSelect_Previews: PreviewProvider {
    static var previews: some View {
        LevelSelect()
    }
}
