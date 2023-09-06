//
//  MainMenu.swift
//  EmotionRecognition
//
//  Created by Rowan Koskoff on 8/4/23.
//

import SwiftUI


struct MainMenu: View {
    @State var showInfoPopup = false
    @State var blurValue = 0.0
    @State var showLevelSelect = false
    var body: some View {
        if showLevelSelect == false
        {
            ZStack{
                Color(.systemGray4).ignoresSafeArea()
                VStack{
                    // move above elephant's head
                    HStack
                    {
                        Spacer().frame(width: 20)
                        Button(action: ExplanationPopup)
                        {
                            ZStack{
                                Ellipse()
                                    .frame(width: 47, height: 47)
                                    .foregroundColor(.gray)
                                Ellipse()
                                    .frame(width: 43, height: 43)
                                    .foregroundColor(.white)
                                // need darker gray
                                Text("?")
                                    .foregroundColor(.gray)
                                    .scaleEffect(2)
                            }
                        }
                    }
                    Image("MainMenuElephant").resizable()
                        .frame(width: 250, height: 250)
                        .rotationEffect(Angle(degrees: -90.0))
                    Button(action: goToLevelSelect)
                    {
                        ZStack
                        {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 260, height: 160).foregroundColor(.gray)
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 255, height: 155)
                                .foregroundColor(.white)
                            VStack{
                                Text("Play")
                                    .font(.title).frame(height: 20)
                                Image("BranchIcon").resizable().frame(width: 251, height: 30)
                                Text("Enhance emotion understanding\n through images and scenarios")
                            }.padding(20)
                        }
                    }.foregroundColor(.black).shadow(radius: 10)
                }.blur(radius: blurValue)
                if showInfoPopup
                {
                    ZStack(alignment: .topTrailing)
                    {
                        ZStack
                        {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 350, height: 360).foregroundColor(.white).shadow(radius: 15.0)
                            Text("This is placeholder text.")
                        }
                        Button("Back")
                        {
                            ExplanationPopup()
                        }.padding(20)
                    }
                }
            }
        }
        else
        {
            LevelSelect()
        }
    }
    func goToLevelSelect()
    {
        showLevelSelect.toggle()
    }
    func goToHome()
    {
        
    }
    func goToProfile()
    {
 
    }
    func ExplanationPopup()
    {
        showInfoPopup.toggle()
        if blurValue < 4.0
        {
            blurValue = 8.0
        }
        else
        {
            blurValue = 0.0
        }
    }
}

struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
    }
}
