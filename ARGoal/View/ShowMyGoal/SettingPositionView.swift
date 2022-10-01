//
//  SettingPositionView.swift
//  ARGoal
//
//  Created by Tomo Shimizu on 2022/09/12.
//

import SwiftUI

// MARK: - 位置設定

struct SettingPositionView: View {
    
    @ObservedObject var vm: ViewModel
        
    @Binding var tabSelection: Int
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        
        ZStack {
            Color(hex: ColorCode.background)
                .edgesIgnoringSafeArea(.all)
                        
            VStack(spacing: 24) {
                
                VStack(alignment: .center, spacing: 16) {
                    Text(Message.settingPosition)
                        .foregroundColor(Color(hex: ColorCode.theme))
                        .font(Font.custom(FontName.higaMaruProNW4, size: 20))
                    Text(Message.settingPositionDescription)
                        .foregroundColor(Color(hex: ColorCode.description))
                        .font(Font.custom(FontName.higaMaruProNW4, size: 12))
                        .lineSpacing(5)
                        .multilineTextAlignment(.center)
                }
                
                ARViewContainer(vm: vm)
                
                HStack {
                    Button(action: {
                        self.presentation.wrappedValue.dismiss()
                    }, label: {
                        BackButtonView()
                    })
                    
                    Spacer()
                    
                    NavigationLink(destination: SettingNotificationView(vm: vm,
                                                                        tabSelection: $tabSelection)) {
                        NextButtonView()
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        vm.onSave()
                    })
                }
            }
            .padding(.top, 80)
            .padding([.horizontal, .bottom], 16)
            .navigationBarHidden(true)
        }
    }
}