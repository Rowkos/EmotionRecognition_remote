//
//  WelcomePage.swift
//  EmotionRecognition
//
//  Created by Rowan Koskoff on 8/12/23.
//

import SwiftUI

struct WelcomePage: View {
    @State var showMainMenu = false;
    var body: some View {
        if showMainMenu
        {
            MainMenu().transition(.slide)
        }
        if showMainMenu == false
        {
            ZStack{
                Color(.systemGray4).ignoresSafeArea()
                VStack{
                    Text("Welcome!")
                        .font(.largeTitle).scaleEffect(1.5)
                    Image("BranchIcon").resizable().frame(width: 251, height: 30).scaleEffect(1.5).padding(.horizontal, 20)
                    Text("Emote is an app designed to help people develop and enhance their emotional processing, interpretation, and understanding")
                        .font(.title)
                        .multilineTextAlignment(.center).padding(20).border(.black).padding(20)
                    Button(action: openMainMenu)
                    {
                        ZStack{
                            Rectangle().frame(width: 150, height: 75).foregroundColor(.gray).cornerRadius(10.0)
                            Text("Continue").scaleEffect(1.5).foregroundColor(.black)
                        }
                    }
                    .frame(width: 75.0)
                    .foregroundColor(.white)
                    .padding(.all, 20.0)
                    .shadow(radius: 15)
                }
            }
        }
    }
    func openMainMenu()
    {
        showMainMenu.toggle()
    }
}

struct WelcomePage_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePage()
    }
}
