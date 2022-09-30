//
//  StartView.swift
//  ARGoal
//
//  Created by Tomo Shimizu on 2022/09/23.
//

import SwiftUI
import ARKit
import RealityKit

// MARK: - 開始

struct StartActionView: View {
    
    @ObservedObject var vm: ViewModel
    
    @Binding var tabSelection: Int
    
    @State private var showMyGoal: Bool = false
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        
        ZStack(alignment: .center) {
            Color(hex: ColorCode.background)
                .edgesIgnoringSafeArea(.all)
                        
            VStack {
                Image("start")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
                
                VStack(spacing: 16) {
                    Text(Message.startAction)
                        .foregroundColor(Color(hex: ColorCode.theme))
                        .font(Font.custom(FontName.higaMaruProNW4, size: 20))
                        .padding()
                    Text(Message.startActionDescription)
                        .foregroundColor(Color(hex: ColorCode.description))
                        .font(Font.custom(FontName.higaMaruProNW4, size: 12))
                        .lineSpacing(5)
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
                
                HStack {
                    Button(action: {
                        self.presentation.wrappedValue.dismiss()
                    }, label: {
                        BackButtonView()
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        UserDefaults.standard.set(vm.myGoal, forKey: "myGoal")
                        self.tabSelection = 0
                    }, label: {
                        StartButtonView()
                    })
                }
            }
            .padding(.top, 80)
            .padding([.horizontal, .bottom], 16)
            .navigationBarHidden(true)
        }
    }
}

struct StartActionARViewContainer: UIViewRepresentable {

    let vm: ViewModel

    func makeUIView(context: Context) -> ARView {

        let arView = ARView(frame: .zero)
        context.coordinator.arView = arView
        arView.session.delegate = context.coordinator
        
        vm.onLoad = {
            context.coordinator.loadWorldMap()
        }
        vm.onClear = {
            context.coordinator.clearWorldMap()
        }

        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(vm: vm)
    }
}